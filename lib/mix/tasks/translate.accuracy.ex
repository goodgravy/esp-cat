defmodule Mix.Tasks.Translate.Accuracy do
  use Mix.Task

  def run(_) do
    IO.puts :stderr, "Translation steps: #{Enum.join(Translate.Transformers.names(), ", ")}"

    test_cases = [Translate.TestCases.Wikibooks, Translate.TestCases.Lexic]

    ratios_for_each_test_case = Enum.flat_map(test_cases, fn(test_case) ->
      stats = test_case.all()
      |> Enum.map(&Translate.case/1)
      |> Translate.analyse_cases
      |> Translate.aggregate_accuracies
      [stats.exact_ratio, stats.accented_ratio]
    end)

    IO.puts Enum.join(ratios_for_each_test_case, "\t")
  end
end
