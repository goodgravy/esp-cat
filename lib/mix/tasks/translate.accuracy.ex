defmodule Mix.Tasks.Translate.Accuracy do
  use Mix.Task

  def run(_) do
    stats = Translate.TestCases.Wikibooks.all()
            |> Enum.map(&Translate.TranslationRecord.from_pair/1)
            |> Enum.map(&Translate.translate/1)
            |> Translate.analyse_records
            |> Translate.aggregate_accuracies

    IO.puts "Translation steps: #{Enum.join(Translate.Transformers.names(), ", ")}"
    IO.puts "Exactly correct: #{stats.exact} (#{stats.exact_ratio})"
    IO.puts "Correct ignoring accents: #{stats.accented} (#{stats.accented_ratio})"
  end
end
