defmodule Translate.Mixfile do
  use Mix.Project

  def project do
    [
      app: :translate,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csv, "~> 2.0.0"},
      {:word_smith, "~> 0.1.0"},
    ]
  end
end
