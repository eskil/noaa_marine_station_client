defmodule NoaaMarineStationClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :noaa_marine_station_client,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      escript: [main_module: NoaaMarineStationClient.Cli],
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.0"},
      {:excoveralls, "~> 0.6", only: :test},
      {:poison, "~> 3.1"},
      {:floki, "~> 0.20.0"}
    ]
  end
end
