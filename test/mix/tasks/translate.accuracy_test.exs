defmodule Mix.Tasks.Translate.AccuracyTest do
  use ExUnit.Case

  test "analyse_cases returns a struct for each case" do
    test_cases = [
      ["exact", "exact"],
      ["accented", "àccénted"],
      ["completely", "different"],
    ]
    results = Mix.Tasks.Translate.Accuracy.analyse_cases(test_cases)

    assert length(results) == 3
    assert Enum.count(results, &(&1.correct_exactly)) == 1
    assert Enum.count(results, &(&1.correct_ignoring_accents)) == 2
  end

  test "aggregate_accuracies creates summary stats" do
    test_cases = [
      ["exact", "exact"],
      ["accented", "àccénted"],
    ]
    results = test_cases
              |> Mix.Tasks.Translate.Accuracy.analyse_cases
              |> Mix.Tasks.Translate.Accuracy.aggregate_accuracies

    assert results.exact == 1
    assert results.exact_ratio == 0.5
    assert results.accented == 2
    assert results.accented_ratio == 1
  end
end
