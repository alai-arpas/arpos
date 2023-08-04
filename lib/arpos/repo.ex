defmodule Arpos.Repo do
  use Ecto.Repo,
    otp_app: :arpos,
    adapter: Ecto.Adapters.Postgres

  def using_postgres? do
    Arpos.Repo.__adapter__() == Ecto.Adapters.Postgres
  end
end
