defmodule NoaaMarineStationClientTest do
  use ExUnit.Case
  doctest NoaaMarineStationClient

  test "read station list success" do
    {:ok, response} = NoaaMarineStationClient.read_station_list()
    assert response =~ "PZZ545"
  end


  test "read station list fail" do
    :error = NoaaMarineStationClient.read_station_list([mock_fail: true])
  end

  test "read station success" do
    {:ok, response} = NoaaMarineStationClient.read_station("PZZ545")
    assert response =~ "Tonight"
  end

  test "read station fail" do
    :error = NoaaMarineStationClient.read_station("bad id")
  end
end
