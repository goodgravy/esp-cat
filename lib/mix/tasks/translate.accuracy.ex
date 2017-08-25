defmodule Mix.Tasks.Translate.Accuracy do
  use Mix.Task

  def run(_) do
    IO.puts "Translation steps: #{Enum.join(Translate.Transformers.names(), ", ")}"

    Enum.each([Translate.TestCases.Wikibooks, Translate.TestCases.Lexic], fn(test_case) ->
      stats = test_case.all()
              |> Enum.map(&Translate.case/1)
              |> Translate.analyse_cases
              |> Translate.aggregate_accuracies

      IO.puts "Test case: #{test_case}"
      IO.puts "Exactly correct: #{stats.exact} (#{stats.exact_ratio})"
      IO.puts "Correct ignoring accents: #{stats.accented} (#{stats.accented_ratio})"
    end)
  end
end
