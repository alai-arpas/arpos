defmodule Arpos.OraDb.Poa do
  def trascodifica do
    url = Application.get_env(:arpos, :oracle_rest_url)
    url_per_tabella = url <> "trascodifica"
    IO.inspect(url_per_tabella, label: "url")
    Req.get!(url_per_tabella).body
  end
end
