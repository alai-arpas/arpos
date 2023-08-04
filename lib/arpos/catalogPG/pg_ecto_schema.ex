defmodule Arpos.CatalogPG.PgEctoSchema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @schema_prefix "pg_catalog"
    end
  end
end
