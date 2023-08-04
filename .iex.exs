import_if_available Ecto.Query

import_if_available Ecto.Changeset

alias Arpos.Repo

alias Arpos.McIdro.McEctoSchema, as: MciEs
alias Arpos.SrvIdroAccdb.SdeEctoSchema, as: SdeEs

alias Arpos.McIdro.{TabAnagraficaStazioni, TabMisurePortata}

alias Arpos.CatalogANSI.Objects.Tables, as: CansiTables
alias Arpos.McIdro.BuildTas

q0 = from a in TabAnagraficaStazioni, where: a.sito_id == "IDR0001"
q1 = from m in TabMisurePortata, where: m.sito_id == "IDR0001"
