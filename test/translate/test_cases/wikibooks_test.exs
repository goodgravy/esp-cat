defmodule Translate.TestCases.WikibooksTest do
  use ExUnit.Case
  doctest Translate.TestCases.Wikibooks

  test "all returns complete set of examples" do
    result = Translate.TestCases.Wikibooks.all()
             |> Enum.to_list

    assert length(result) == 707
    assert Enum.at(result, 666) == ["vaso", "vas"]
  end
end
