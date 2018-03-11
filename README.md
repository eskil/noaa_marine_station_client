# NoaaMarineStationClient

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `noaa_marine_station_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:noaa_marine_station_client, "~> 0.1.0"}
  ]
end
```

```elixir
def deps do
  [
    {:noaa_marine_station_client, github: "eskil/noaa_marine_station_client"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/noaa_marine_station_client](https://hexdocs.pm/noaa_marine_station_client).


# Intro

We're going to make a client to scrape NOAA info and a CLI tool to use
it. It'll work roughly like

```sh
$ ./noaa_marine_station_client --list
PZZ545
...

$ ./noaa_marine_station_client --read-station=PZZ545
TODAY...
TONIGHT ...
TOMORROW ...
```

To keep this README readable, I'll omit all the actual HTML
scraping (using [floki](https://github.com/philss/floki) and instead
just pass the html unparsed. The final code in the github repo will
have the actual scraping.

I'll also omit the fact that to actually get the complete list of NOAA
stations (not just West Coast), you need to go through multiple pages
to collect station ids, and some ids aren't really stations but
synopsis links. Anyway, ignore that, and let's just connect a
commandline tool to an API and to a HTTP client.

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

## TODO

  * Add client api
    * api functions
    * specs
    * docstrings
    * parse response functions
  * Add test
    * most basics for successful function returns
    * most basics for failures
  * Add http client
    * process_url
    * functions for endpoint
  * Add http mock
    *
  * Add cli
    * Setup for escript cli
  * Publish on hex

## Add the client API

We'll start with defining the the client API.
```elixir
defmodule NoaaMarineStationClient do
  @moduledoc """
  Client for reading and scraping info from
  http://marine.weather.gov/MapClick.php?zoneid=<stationid>&TextType=1

  http://www.nws.noaa.gov/wtf/MapClick.php?zoneid=PZZ545

  You can find a list of stations at http://www.nws.noaa.gov/om/marine/marsamepac.htm.
  """

  require Logger

  @http_client Application.get_env(:noaa_marine_station_client, :http_client) ||
    NoaaMarineStationClient.HttpClient

  defp parse_station_response(response) do
    # TODO: use floki to scrape the html
    {:ok, response}
  end

  defp parse_station_list_response(response) do
    # TODO: use floki to scrape the html
    {:ok, response}
  end

  def read_station(station_id) do
    case @http_client.read_station(station_id) do
      %{status_code: 200, body: body} ->
        parse_station_response(body)
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station #{station_id}"
        Logger.warn "[NoaaMarineStationClient] Response #{inspect response}"
        :error
    end
  end

  def read_station_list() do
    case @http_client.read_station_list() do
      %{status_code: 200, body: body} ->
        parse_station_list_response(body)
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station list"
        Logger.warn "[NoaaMarineStationClient] Response #{inspect response}"
        :error
    end
  end
end
```

An important detail here is using a module attribute `@http_client` to
access the NOAA site.

```elixir
  @http_client Application.get_env(:noaa_marine_station_client, :http_client) ||
    NoaaMarineStationClient.HttpClient
```

This is in the spirit of [elixir style mocking for
tests](http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/). It
decouples the http client from the API, thereby allowing us to swap it
out with another or a mock when in testing environment.

This means that any environment can specify the client through config as in

```elixir
config :noaa_marine_station_client,
  http_client: SomeNoaaMarineStationClient.HttpClient
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

Now define `NoaaMarineStationClient.HttpClient`. It uses
`HTTPotion.Base` and provides the functions that we called on
`@http_client` in `NoaaMarineStationClient`.

```elixir
defmodule NoaaMarineStationClient.HttpClient do
  use HTTPotion.Base
  alias NoaaMarineStationClient.HttpClient

  defp process_url(url) do
    "http://www.nws.noaa.gov" <> url
  end

  def read_station(station_id) do
    HttpClient.get!("/wtf/MapClick.php?zoneid=#{station_id}", [timeout: 10_000])
  end

  def read_station_list() do
    # This page contains the West Coast stations only.
    HttpClient.get("/om/marine/marsamepac.htm", [timeout: 10_000])
  end
end
```

Since the http client is a module attribute as per previous
section. It'd be easy to replace the HTTPotion implementation with
another, like
[HTTPosion](https://github.com/edgurgel/httpoison#wrapping-httpoisonbase)
or [Tesla](https://github.com/teamon/tesla). Whatever floats your boat.

## Add a mock client



## Add a test


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
