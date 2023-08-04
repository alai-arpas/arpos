defmodule Arpos.CatalogANSI.InformationEctoSchema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @schema_prefix "information_schema"
    end
  end
end
