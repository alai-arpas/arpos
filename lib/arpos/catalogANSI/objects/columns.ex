defmodule Arpos.CatalogANSI.Objects.Columns do
  use Arpos.CatalogANSI.InformationEctoSchema

  @primary_key {:table_name, :string, autogenerate: false}

  schema "columns" do
    field(:column_name, :string)
    field(:ordinal_position, :integer)
    field(:data_type, :string)
  end
end
