defmodule NoaaMarineStationClient.Cli do
  @moduledoc """
  noaa_marine_station_client reads NOAA Marine Station forecast data.

  --read-station=<station id>, ie. PZZ545 for the SF Bay Area.
  """

  def main(args) do
    args |> parse_args |> process
  end

  defp help() do
    IO.puts @moduledoc
    System.halt(0)
  end

  defp parse_args(args) do
    {options, args, invalid} = OptionParser.parse(
      args,
      aliases: [h: :help]
    )
    case options[:help] do
      true  -> help()
      _ -> {options, args, invalid}
    end
  end

  defp display_station_data({:ok, data}) do
    IO.puts inspect data
  end

  defp display_station_data(_) do
    IO.puts "Cannot load station data"
  end

  def process({[read_station: station_id], [], _invalid}) do
    display_station_data(NoaaMarineStationClient.read_station(station_id))
  end

  def process({_options, _commands, _invalid}) do
    IO.puts "Unknown/missing command see --help"
    System.halt(0)
  end
end
