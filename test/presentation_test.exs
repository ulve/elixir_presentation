defmodule PresentationTest do
  use ExUnit.Case
  doctest Presentation

  test "greets the world" do
    assert Presentation.hello() == :world
  end
end
