defmodule NoaaMarineStationClientTest do
  use ExUnit.Case
  doctest NoaaMarineStationClient

  test "read station success" do
    {:ok, response} = NoaaMarineStationClient.read_station("PZZ545")
    assert response =~ "Tonight"
  end

  test "read station fail" do
    :error = NoaaMarineStationClient.read_station("bad id")
  end
end
