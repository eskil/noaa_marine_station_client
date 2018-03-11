defmodule NoaaMarineStationClient do
  @moduledoc """
  Client for reading and scraping info from
  http://marine.weather.gov/MapClick.php?zoneid=<stationid>&TextType=1

  http://www.nws.noaa.gov/wtf/MapClick.php?zoneid=PZZ545

  You can find a list of stations at http://www.nws.noaa.gov/om/marine/marsamepac.htm.
  """

  require Logger

  # Compile time pick a client or default to the production http client
  @http_client Application.get_env(:noaa_marine_station_client, :http_client) ||
    NoaaMarineStationClient.Client.HttpClient

  defp parse_station_response(response) do
    # TODO: use floki to scrape the html
    {:ok, response}
  end

  @doc """
  Fetch weather data from the given station id
  """
  def read_station(station_id, opts \\ []) do
    case @http_client.fetch_station_data(station_id, opts) do
      %{status_code: 200, body: body} ->
        parse_station_response(body)
      response ->
        Logger.warn "[NoaaMarineStationClient] Cannot read station #{station_id}"
        Logger.warn "[NoaaMarineStationClient] Response #{inspect response}"
        :error
    end
  end
end
