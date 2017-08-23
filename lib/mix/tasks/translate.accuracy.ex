defmodule Mix.Tasks.Translate.Accuracy do
  use Mix.Task
  defstruct [:correct_exactly, :correct_ignoring_accents]

  def run(_) do
    stats = Translate.TestCases.Wikibooks.all()
            |> Enum.map(&translate_case/1)
            |> analyse_cases
            |> aggregate_accuracies

    IO.puts "Translation steps: #{Enum.join(Translate.step_names, ", ")}"
    IO.puts "Exactly correct: #{stats.exact} (#{stats.exact_ratio})"
    IO.puts "Correct ignoring accents: #{stats.accented} (#{stats.accented_ratio})"
  end

  def translate_case([esp_word, cat_word]) do
    [Translate.esp_to_cat(esp_word), cat_word]
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
      exact_ratio: num_exact / num_accuracies,
      accented_ratio: num_accented / num_accuracies,
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
