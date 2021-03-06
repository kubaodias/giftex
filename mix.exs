defmodule Giftex.MixProject do
  use Mix.Project

  def project do
    [
      app: :giftex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mox, "~> 0.4", only: :test},
      {:yaml_elixir, "~> 2.0"},
      {:httpotion, "~> 3.1"},
      {:poison, "~> 3.1"},
      {:mustache, "~> 0.3.0"}
    ]
  end
end
