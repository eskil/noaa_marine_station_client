defmodule NoaaMarineStationClient.Client do
  @type station_id :: String.t
  @type zone_url :: String.t
  @type opts :: Keyword.t

  @callback fetch_station_data(station_id, opts) :: []
  @callback fetch_station_list(zone_url, opts) :: []
  @callback fetch_zone_list(opts) :: %{}
end
