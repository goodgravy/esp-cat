defmodule Translate.Transformers do
  def names, do: Keyword.keys(steps())
  def funcs, do: Keyword.values(steps())

  def ue_to_o(word), do: String.replace(word, "ue", "o")
  def ie_to_e(word), do: String.replace(word, "ie", "e")
  def ion_to_io(word), do: String.replace(word, ~r/ión$/, "ió")
  def drop_o(word), do: String.replace(word, ~r/o$/, "")
  def drop_e(word), do: String.replace(word, ~r/e$/, "")

  defp steps do
    [
      ue_to_o: &ue_to_o/1,
      ie_to_e: &ie_to_e/1,
      ion_to_io: &ion_to_io/1,
      drop_o: &drop_o/1,
      drop_e: &drop_e/1,
    ]
  end
end
