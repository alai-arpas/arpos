defmodule Arpos.CatalogANSI.Objects.Tables do
  use Arpos.CatalogANSI.InformationEctoSchema

  @primary_key {:table_name, :string, autogenerate: false}

  schema "tables" do
    field(:table_catalog, :string)
    field(:table_schema, :string)
    field(:table_type, :string)
  end
end
