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

```sh
mix new noaa_marine_station_client
cd noaa_marine_station_client
git init .
git add *
git commit -m "Initial commit"
```

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
