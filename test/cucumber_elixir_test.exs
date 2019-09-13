defmodule CucumberElixirTest do
  use ExUnit.Case
  doctest CucumberElixir

  import ExUnit.CaptureIO

  test "tokenize a .feature file" do
    file = "./test/fixtures/test.feature"

    assert CucumberElixir.tokenize(file) == [
             %{
               keyword: :feature,
               name: " Multiple site support",
               description:
                 "  Only blog owners can post to a blog, except administrators,\n  who can post to all blogs."
             }
           ]
  end
end
