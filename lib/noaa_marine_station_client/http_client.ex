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
    HttpClient.get!(url, Keyword.merge([timeout: 10_000], opts))
  end
end
