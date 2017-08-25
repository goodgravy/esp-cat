defmodule TranslateTest do
  use ExUnit.Case
  doctest Translate

  test "analyse_records returns a struct for each case" do
    test_cases = [
      ["exact", "exact"],
      ["accented", "àccénted"],
      ["completely", "different"],
    ]

    results = test_cases
              |> Enum.map(&Translate.TranslationRecord.from_pair/1)
              |> Enum.map(&Translate.translate/1)
              |> Translate.analyse_records

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
              |> Enum.map(&Translate.TranslationRecord.from_pair/1)
              |> Enum.map(&Translate.translate/1)
              |> Translate.analyse_records
              |> Translate.aggregate_accuracies

    assert results.exact == 1
    assert results.exact_ratio == 0.5
    assert results.accented == 2
    assert results.accented_ratio == 1
  end
end
