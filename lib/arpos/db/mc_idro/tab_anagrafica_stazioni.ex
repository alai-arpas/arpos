defmodule Arpos.Db.McIdro.TabAnagraficaStazioni do
  use Arpos.Db.McIdro.McEctoSchema
  alias Arpos.Db.McIdro.TabMisurePortata

  @primary_key {:sito_id, :string, primary_key: true, autogenerate: false}

  schema "anagrafica_stazioni" do
    field(:cod_staz, :string)
    field(:nome_staz, :string)
    has_many(:misure_di_portata, TabMisurePortata, foreign_key: :misure_id)
  end
end
