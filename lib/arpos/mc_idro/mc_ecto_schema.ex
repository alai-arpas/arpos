defmodule Arpos.McIdro.McEctoSchema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @schema_prefix "mc_idro"
    end
  end
end
