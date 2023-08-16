defmodule Arpos.MixProject do
  use Mix.Project

  @version "0.1.9"

  def project do
    [
      app: :arpos,
      version: @version,
      elixir: "~> 1.15",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp description do
    "Internal Project, don't waste your time here."
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
      {:postgrex, ">= 0.0.0"},
      # {:jamdb_oracle, "~> 0.5.5"},
      {:explorer, "~> 0.6.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:req, "~> 0.3.11"}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/alai-arpas/arpos"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      wv: ["arpos -awv"]
      # alai: ["run priv/repo/alai_seeds.exs"]
      # "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
