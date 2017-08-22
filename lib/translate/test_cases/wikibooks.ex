defmodule Translate.TestCases.Wikibooks do
  def all do
    YamlElixir.read_from_file(path())
  end

  defp path do
    File.cwd! |> Path.join("test-cases/wikibooks.yaml")
  end
end
