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
    response
  end

  defp parse_station_list_response(response) do
    response
  end

  def read_station(station_id) do
    case @http_client.read_station(station_id) do
      %{status_code: 200, body: body} ->
        parse_station_response(Poison.decode(body))
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station #{station_id}"
        Logger.warn "Response #{inspect response}"
        :error
    end
  end

  def read_station_list() do
    case @http_client.read_list_station(station_id) do
      %{status_code: 200, body: body} ->
        parse_station_response(Poison.decode(body))
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station list"
        Logger.warn "Response #{inspect response}"
        :error
    end
  end
end
