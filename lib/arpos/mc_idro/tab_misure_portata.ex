defmodule Arpos.McIdro.TabMisurePortata do
  use Arpos.McIdro.McEctoSchema

  alias Arpos.McIdro.TabAnagraficaStazioni

  @primary_key {:misure_id, :string, autogenerate: false}

  schema "misure_portata" do
    field(:esec_misure, :string)
    field(:sito_id, :string)

    belongs_to(:stazione, TabAnagraficaStazioni,
      # referenzia il campo definito sopra, definito come :string
      # altrimenti lo traterebbe come un :id
      references: :sito_id,
      # non generare il campo "stazione_id" -> belongs_to(:stazione
      define_field: false
    )
  end
end
