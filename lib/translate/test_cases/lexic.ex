defmodule Translate.TestCases.Lexic do
  def all do
    File.stream!(path()) |> CSV.decode!(separator: ?\t)
  end

  defp path do
    File.cwd! |> Path.join("test-cases/lexic.tsv")
  end
end

