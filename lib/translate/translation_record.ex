defmodule Translate.TranslationRecord do
  defstruct [:esp_word, :cat_word, :intermediate_words, :analyses]

  def from_pair([esp_word, cat_word]) do
    %__MODULE__{
      esp_word: esp_word,
      cat_word: cat_word,
      intermediate_words: [esp_word],
      analyses: [],
    }
  end

  def add_intermediate(record, intermediate) do
    %__MODULE__{
      esp_word: record.esp_word,
      cat_word: record.cat_word,
      intermediate_words: [intermediate] ++ record.intermediate_words,
      analyses: record.analyses,
    }
  end

  def add_analyses(record, analyses) do
    %__MODULE__{
      esp_word: record.esp_word,
      cat_word: record.cat_word,
      intermediate_words: record.intermediate_words,
      analyses: analyses,
    }
  end
end
