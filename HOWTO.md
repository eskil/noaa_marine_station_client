# Intro

We're going to make a client to scrape NOAA info and a CLI tool to use
it. It'll work roughly like

```sh
$ ./noaa_marine_station_client --read-station=PZZ545
TODAY...
TONIGHT ...
TOMORROW ...
```

To keep this README readable, I'll omit all the actual HTML
scraping (using [floki](https://github.com/philss/floki) and instead
just print the HTML unparsed. The final code in the github repo will
have the actual scraping.

I'll also omit fetching the list of available station ids in the
README, but it will be in the final code.

# Steps

## Initial Repo

Start a new project with `mix`, create a new git repo and commit those files.

```sh
mix new noaa_marine_station_client
cd noaa_marine_station_client
git init .
git add *
git commit -m "Initial commit"
```

## Add the client API

We'll start with defining the the client API in `lib/noaa_marine_station_client.ex`

```elixir
defmodule NoaaMarineStationClient do
  @moduledoc """
  Client for reading weather station data from marine NOAA stations.

  Reads and scrapes data
  http://www.nws.noaa.gov/wtf/MapClick.php?zoneid=PZZ545&TextType=1

  You can find a list of stations at
  http://www.nws.noaa.gov/om/marine/marsamepac.htm for West Coast, and
  you can find a list of regions at
  http://www.nws.noaa.gov/om/marine/marsame.htm
  """

  require Logger

  # Compile time pick a client or default to the production http client
  @http_client Application.get_env(:noaa_marine_station_client, :http_client) ||
    NoaaMarineStationClient.Client.HttpClient

  defp parse_station_response(response) do
    # TODO: use floki to scrape the html
    {:ok, response}
  end

  @doc """
  Fetch weather data from the given station id

  To specific arguments for the underlying HTTP library, set the appropriate
  keyword values in `opts[:http_client]`.
  """
  def read_station(station_id, opts \\ []) do
    case @http_client.fetch_station_data(station_id, opts) do
      %{status_code: 200, body: body} ->
        parse_station_response(body)
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station #{station_id}"
        Logger.warn "[NoaaMarineStationClient] Response #{inspect response}"
        :error
    end
  end
end
```

An important detail here is using a module attribute `@http_client` to
access the NOAA site.

Also note that we passthrough `opts` right now. This way, for good and bad,
you allow the caller to pass some info to the underlying client. This
is good for being able to eg. pass options to the underlying HTTP
client if you need (or flags for the mock we write later). And it can
be bad if misused to create unnecessarily tight integration between
the caller and the underlying client.

```elixir
  @http_client Application.get_env(:noaa_marine_station_client, :http_client) ||
    NoaaMarineStationClient.Client.HttpClient
```

This is in the spirit of [elixir style mocking for
tests](http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/). It
decouples the HTTP client from the API, thereby allowing us to swap it
out with another or a mock when in testing environment.

This means that any environment can specify the client through config as in

```elixir
config :noaa_marine_station_client,
  http_client: MyOtherClient
```

## Add the actual HTTP client

So let's specify the actual HTTP client. We'll use
[HTTPotion](https://github.com/myfreeweb/httpotion) which makes it
easy to create API specific clients. See
[here](https://github.com/myfreeweb/httpotion#metaprogramming-magic)
for how to do that.

First add HTTPotion to our package `deps` in `mix.exs`.

```diff
diff --git a/mix.exs b/mix.exs
index 6ef7377..f25c584 100644
--- a/mix.exs
+++ b/mix.exs
@@ -21,8 +21,7 @@ defmodule NoaaMarineStationClient.Mixfile do
   # Run "mix help deps" to learn about dependencies.
   defp deps do
     [
-      # {:dep_from_hexpm, "~> 0.3.0"},
-      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
+      {:httpotion, "~> 3.0"}
     ]
   end
 end
```

Define a module for the `behaviour` of our client. This helps us
ensure that both prod, dev and test mocks have the same API. In
`lib/noaa_marine_station_client/client.ex`

```elixir
defmodule NoaaMarineStationClient.Client do
  @type station_id :: String.t
  @type opts :: Keyword.t

  @doc """
  Fetch weather data from the given station id
  """
  @callback fetch_station_data(station_id, opts) :: []
end
```

Now define `NoaaMarineStationClient.Client.HttpClient` in
`lib/noaa_marine_station_client/http_client.ex`. It uses
`HTTPotion.Base` and provides the functions that we call through
`@http_client` in `NoaaMarineStationClient` and defined on
`NoaaMarineStationClient.Client`.

```elixir
defmodule NoaaMarineStationClient.Client.HttpClient do
  # Module must adhere to the NoaaMarineStationClient.Client API
  @behaviour NoaaMarineStationClient.Client

  # Import HTTPotion.Base functions
  use HTTPotion.Base

  # Alias in ourselves to shorten calls
  alias NoaaMarineStationClient.Client.HttpClient

  defp process_url(url) do
    "http://www.nws.noaa.gov" <> url
  end

  def fetch_station_data(station_id, opts) do
    url = "/wtf/MapClick.php?zoneid=#{station_id}&TextType=1"
    HttpClient.get!(url, Keyword.merge([timeout: 10_000], opts[:http_client] || []))
  end
end
```

Note we pick up `opts[:http_client]` and merge in some reasonable
defaults that we "know" we'll need for the underlying HTTP library.

Since the HTTP client is a module attribute as per previous
section. It'd be easy to replace the HTTPotion implementation with
another, like
[HTTPosion](https://github.com/edgurgel/httpoison#wrapping-httpoisonbase)
or [Tesla](https://github.com/teamon/tesla). Whatever floats your
boat.

## Add a test

The client we have now doesn't parse the HTML response, so our test
will simply look for strings within the HTML for now. The final
version in github will do the right thing.

Change up `config/config.exs` to include an environment specific file.

```diff
diff --git a/config/config.exs b/config/config.exs
index bbbdb67..d8273c3 100644
--- a/config/config.exs
+++ b/config/config.exs
@@ -27,4 +27,4 @@ use Mix.Config
 # Configuration from the imported file will override the ones defined
 # here (which is why it is important to import them last).
 #
-#     import_config "#{Mix.env}.exs"
+import_config "#{Mix.env}.exs"
```

Create a `config/prod.exs` and `config/dev.exs` with just

```elixir
use Mix.Config
```

and a `config/test.exs` with

```elixir
use Mix.Config

config :noaa_marine_station_client,
  http_client: NoaaMarineStationClient.Client.Mock
```

Write a unit test on `test/noaa_marine_station_client_test.exs`

```elixir
defmodule NoaaMarineStationClientTest do
  use ExUnit.Case
  doctest NoaaMarineStationClient

  test "read station success" do
    {:ok, response} = NoaaMarineStationClient.read_station("PZZ545")
    assert response =~ "Tonight"
  end

  test "read station fail" do
    :error = NoaaMarineStationClient.read_station("bad id")
  end
end
```

There's a `doctest` statement in there in case you add [doctest](https://hexdocs.pm/elixir/writing-documentation.html#doctests) statements to your client.

Now we need a mock client for testing.

## Add a mock client

Write your mock in
`lib/noaa_marine_station_client/http_client_mock.ex`. Be able to test
out different behaviour in the test (success/failure), we rely on the
arguments or options passed to the client call.

```elixir
defmodule NoaaMarineStationClient.Client.Mock do
  # Module must adhere to the NoaaMarineStationClient.Client API
  @behaviour NoaaMarineStationClient.Client

  def fetch_station_data(station_id, _opts \\ [])

  def fetch_station_data("bad id", _opts) do
    %{
      status_code: 404
    }
  end

  def fetch_station_data("PZZ545", _opts) do
    %{
      status_code: 200,
      body: """
      <title>Coastal Waters Forecast for Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545) (Text-Only)</title>
      ...
      html...
      ...
      """
    }
  end
end
```

## Add a CLI tool

Having a CLI tool with your client is a convenient way to play around
with your client library both for testing or writing actual tools.

[This](http://asquera.de/blog/2015-04-10/writing-a-commandline-app-in-elixir/)
blog post explains the steps of writing an elixir command line tool,
and that's basically what we do here.

`mix` needs to know the main function to call for the cli too, so the
first step is to specific this. It calls `main/1` in the specified
module. In this case, `NoaaMarineStationClient.Cli.main/1` is our main function.

```diff
diff --git a/mix.exs b/mix.exs
index 6ef7377..d46b6f1 100644
--- a/mix.exs
+++ b/mix.exs
@@ -7,6 +7,7 @@ defmodule NoaaMarineStationClient.Mixfile do
       version: "0.1.0",
       elixir: "~> 1.5",
       start_permanent: Mix.env == :prod,
+      escript: [main_module: NoaaMarineStationClient.Cli],
       deps: deps()
     ]
   end
```

Now in `lib/noaa_marine_station_client/cli.ex` specify the `NoaaMarineStationClient.Cli` module.

```elixir
defmodule NoaaMarineStationClient.Cli do
  @moduledoc """
  noaa_marine_station_client reads NOAA Marine Station forecast data.

  --read-station=<station id>, ie. PZZ545 for the SF Bay Area.
  """

  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp help() do
    IO.puts @moduledoc
    System.halt(0)
  end

  defp parse_args(args) do
    {options, args, invalid} = OptionParser.parse(
      args,
      aliases: [h: :help]
    )
    case options[:help] do
      true  -> help()
      _ -> {options, args, invalid}
    end
  end

  defp display_station_data({:ok, data}) do
    IO.puts inspect data
  end

  defp display_station_data(_) do
    IO.puts "Cannot load station data"
  end

  def process({[read_station: station_id], [], _invalid}) do
    display_station_data(NoaaMarineStationClient.read_station(station_id))
  end

  def process({_options, _commands, _invalid}) do
    IO.puts "Unknown/missing command see --help"
    System.halt(0)
  end
end
```

## Run and test

```sh
$ mix test
$ mix test
Compiling 5 files (.ex)
Generated noaa_marine_station_client app
.
15:37:46.149 [warn]  [NoaaMarineStationClient] Cannot read station bad id

15:37:46.154 [warn]  [NoaaMarineStationClient] Response %{status_code: 404}
.

Finished in 0.04 seconds
2 tests, 0 failures

Randomized with seed 94610
```

That's what we expected. Now run the CLI tool.

```sh
$ mix escript.build
Compiling 5 files (.ex)
Generated noaa_marine_station_client app
Generated escript noaa_marine_station_client with MIX_ENV=dev

$ ./noaa_marine_station_client --read-station=PZZ545
"<title>Coastal Waters Forecast for Coastal Waters from Point Reyes to
Pigeon Point California out to 10 nm (PZZ545)
(Text-Only)</title>\n...<b>Synopsis</b>...GREATER FARALLONES...AND
CORDELL BANK\nNATIONAL MARINE SANCTUARIES.....Today</b>...NW winds 10
to 20 kt. Wind waves 2 to 4 ft. NW swell 5 to 7 ft at 8
seconds.<br><br>\n"
```

Voila. That's the basic steps of creating a testable HTTP client for other things.
