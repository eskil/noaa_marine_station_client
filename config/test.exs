use Mix.Config

config :noaa_marine_station_client,
  http_client: NoaaMarineStationClient.Client.Mock
