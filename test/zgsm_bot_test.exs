defmodule ZgsmBotTest do
  use ExUnit.Case
  doctest ZgsmBot

  test "greets the world" do
    assert ZgsmBot.hello() == :world
  end
end
