defmodule Arpos.Application do
  # See https://hexdocs.pm/elixir/Application.html

  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Arpos.Repo
      # Arpos.RepoOra - per ora non funziona - rivedere erlang odbc
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    opts = [strategy: :one_for_one, name: Test.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
