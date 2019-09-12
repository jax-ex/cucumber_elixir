defmodule CucumberElixirTest do
  use ExUnit.Case
  doctest CucumberElixir

  test "greets the world" do
    assert CucumberElixir.hello() == :world
  end
end
