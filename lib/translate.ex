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
    [
      ue_to_o: &ue_to_o/1,
      ie_to_e: &ie_to_e/1,
      ion_to_io: &ion_to_io/1,
      drop_o: &drop_o/1,
      drop_e: &drop_e/1,
    ]
  end

  defp ue_to_o(word), do: String.replace(word, "ue", "o")
  defp ie_to_e(word), do: String.replace(word, "ie", "e")
  defp ion_to_io(word), do: String.replace(word, ~r/ión$/, "ió")
  defp drop_o(word), do: String.replace(word, ~r/o$/, "")
  defp drop_e(word), do: String.replace(word, ~r/e$/, "")
end
