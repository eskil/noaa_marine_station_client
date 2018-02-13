defmodule NoaaMarineStationClient.Cli do
  @moduledoc """
  noaa_marine_station_client reads NOAA Marine Station forecast data.

  --station-id=<station id>

  Eg. PZZ545 for the SF Bay Area.
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
      strict: [
        login: :string,
        password: :string,
        help: :boolean,
        fleet: :string,
        start_date: :string
      ],
      aliases: [h: :help]
    )
    case options[:help] do
      true  -> help()
      _ -> {options, args, invalid}
    end
  end

  def process({options, [], _invalid}) do
    {:ok, data} = NoaaMarineStationClient.read_station(options[:station_id])
    IO.inspect(data)
  end

  def process({_options, _commands, _invalid}) do
    IO.puts "Unknown/missing command see --help"
    System.halt(0)
  end
end
