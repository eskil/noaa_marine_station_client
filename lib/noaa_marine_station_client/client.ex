defmodule NoaaMarineStationClient.Client do
  @type station_id :: String.t
  @type opts :: Keyword.t

  @doc """
  Fetch weather data from the given station id
  """
  @callback fetch_station_data(station_id, opts) :: []
end
