defmodule Translate do
  @moduledoc """
  Documentation for Translate.
  """

  defstruct [:correct_exactly, :correct_ignoring_accents]

  def translate(record) do
    Enum.reduce(Translate.Transformers.funcs(), record, fn(fun, record) ->
      intermediate = fun.(hd record.intermediate_words)
      Translate.TranslationRecord.add_intermediate(record, intermediate)
    end)
  end

  def analyse_records(records) do
    records |> Enum.map(&analyse/1) |> Enum.map(&correctness/1)
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

  defp analyse(record) do
    analyses = Enum.map(
      record.intermediate_words,
      fn(intermediate) ->
        [
          correct_exactly: correct_exactly(intermediate, record.cat_word),
          correct_ignoring_accents: correct_ignoring_accents(intermediate, record.cat_word),
        ]
      end
    )

    Translate.TranslationRecord.add_analyses(record, analyses)
  end

  defp correctness(record) do
    %__MODULE__{
      correct_exactly: hd(record.analyses)[:correct_exactly],
      correct_ignoring_accents: hd(record.analyses)[:correct_ignoring_accents],
    }
  end

  defp correct_exactly(esp_word, cat_word) do
    esp_word == cat_word
  end

  defp correct_ignoring_accents(esp_word, cat_word) do
    WordSmith.remove_accents(esp_word) == WordSmith.remove_accents(cat_word)
  end
end
