defmodule Translate do
  @moduledoc """
  Documentation for Translate.
  """

  def esp_to_cat(esp_word) do
    Enum.reduce(step_funcs(), esp_word, fn(fun, word) ->
      fun.(word)
    end)
  end

  def step_names, do: Keyword.keys(steps())

  defp step_funcs, do: Keyword.values(steps())

  defp steps do
    [ue_to_o: &ue_to_o/1]
  end

  defp ue_to_o(word) do
    String.replace(word, "ue", "o")
  end
end
