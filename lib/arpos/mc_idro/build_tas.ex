defmodule Arpos.McIdro.BuildTas do
  alias Arpos.Repo

  import Ecto.Query

  def campi do
    table_name = "anagrafica_stazioni"

    q =
      from(c in "columns",
        prefix: "information_schema",
        where: [table_name: ^table_name],
        order_by: [:ordinal_position],
        select: [:column_name, :data_type]
      )

    Repo.all(q)
  end
end
