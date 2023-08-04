defmodule Arpos.SrvIdroAccdb.SdeEctoSchema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @schema_prefix "sde"
    end
  end
end
