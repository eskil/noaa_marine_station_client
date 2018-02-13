defmodule NoaaMarineStationClientTest do
  use ExUnit.Case
  doctest NoaaMarineStationClient

  test "greets the world" do
    assert NoaaMarineStationClient.hello() == :world
  end
end
