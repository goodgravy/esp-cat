defmodule Translate.TranslationRecord do
  defstruct [:esp_word, :intermediate_words, :cat_word]

  def from_pair([esp_word, cat_word]) do
    %__MODULE__{
      esp_word: esp_word,
      intermediate_words: [esp_word],
      cat_word: cat_word
    }
  end

  def add_intermediate(record, intermediate) do
    %__MODULE__{
      esp_word: record.esp_word,
      intermediate_words: [intermediate] ++ record.intermediate_words,
      cat_word: record.cat_word,
    }
  end
end
