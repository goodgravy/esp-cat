defmodule Translate.TestCases.LexicTest do
  use ExUnit.Case

  test "all returns complete set of examples" do
    result = Translate.TestCases.Lexic.all()
             |> Enum.to_list

    assert length(result) == 1445
    assert Enum.at(result, 998) == ["antecocina", "office"]
  end
end
