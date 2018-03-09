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
    HttpClient.get("/om/marine/marsamepac.htm", [timeout: 10_000])
  end
end
