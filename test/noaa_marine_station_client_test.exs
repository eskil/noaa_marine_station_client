defmodule NoaaMarineStationClientTest do
  use ExUnit.Case
  doctest NoaaMarineStationClient

  test "read station list" do
    {:ok, response} = NoaaMarineStationClient.read_station_list()
    assert response =~ "PZZ545"
  end

  test "read station PZZ545" do
    {:ok, response} = NoaaMarineStationClient.read_station("PZZ545")
    assert response =~ "Tonight"
  end
end
