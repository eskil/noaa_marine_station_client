defmodule NoaaMarineStationClient.HttpClient do
  use HTTPotion.Base
  alias NoaaMarineStationClient.HttpClient

  defp process_url(url) do
    "http://marine.weather.gov" <> url
  end

  def read_station(station_id) do
    HttpClient.get!("/MapClick.php?zoneid=#{station_id}&TextType=1")
  end
end
