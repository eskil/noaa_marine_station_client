defmodule NoaaMarineStationClient do
  @moduledoc """
  Client for reading and scraping info from http://marine.weather.gov/MapClick.php?zoneid=<stationid>&TextType=1
  """

  require Logger

  @http_client Application.get_env(:noaa_marine_station_client, :http_client) ||
    NoaaMarineStationClient.HttpClient

  defp parse_response(response) do
    response
  end

  def read_station(station_id) do
    case @http_client.read_station(station_id) do
      %{status_code: 200, body: body} ->
        parse_response(Poison.decode(body))
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station #{station_id}"
        Logger.warn "Response #{inspect response}"
        :error
    end
  end
end
