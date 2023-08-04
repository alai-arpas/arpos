defmodule Arpos.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :arpos,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Arpos.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10.1"},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"]
      # alai: ["run priv/repo/alai_seeds.exs"]
      # "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end