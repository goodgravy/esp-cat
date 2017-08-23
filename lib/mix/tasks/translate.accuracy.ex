defmodule Mix.Tasks.Translate.Accuracy do
  use Mix.Task
  defstruct [:correct_exactly, :correct_ignoring_accents]

  def run(_) do
    stats = Translate.TestCases.Wikibooks.all()
    |> analyse_cases
    |> aggregate_accuracies
    IO.puts "Exactly correct: #{stats.exact} (#{stats.exact_percentage}%)"
    IO.puts "Correct ignoring accents: #{stats.accented} (#{stats.accented_percentage}%)"
  end

  def analyse_cases(cases) do
    cases
    |> Enum.map(&correctness/1)
  end

  def aggregate_accuracies(accuracies) do
    num_accuracies = Enum.count(accuracies)
    num_exact = Enum.count(accuracies, &(&1.correct_exactly))
    num_accented = Enum.count(accuracies, &(&1.correct_ignoring_accents))
    %{
      exact: num_exact,
      accented: num_accented,
      exact_percentage: num_exact / num_accuracies * 100,
      accented_percentage: num_accented / num_accuracies * 100,
    }
  end

  defp correctness([esp_word, cat_word]) do
    %__MODULE__{
      correct_exactly: correct_exactly(esp_word, cat_word),
      correct_ignoring_accents: correct_ignoring_accents(esp_word, cat_word),
    }
  end

  defp correct_exactly(esp_word, cat_word) do
    esp_word == cat_word
  end

  defp correct_ignoring_accents(esp_word, cat_word) do
    WordSmith.remove_accents(esp_word) == WordSmith.remove_accents(cat_word)
  end
end
