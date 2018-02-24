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


# Steps

## Start a new repo

```sh
mix new noaa_marine_station_client
cd noaa_marine_station_client
git init .
git add *
git commit -m "Initial commit"
```

## TODO

  * Setup for escript cli
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
  * Publish on hex

## Add the client API

## Add the actual HTTP client

## Add a mock client

<why>

## Add a test


## Add a CLI tool

Having a CLI too with your client is a convenient way to play around
with it and test the client against the real deal.

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

First you need to specific
