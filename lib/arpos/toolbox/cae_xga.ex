defmodule Arpos.Toolbox.CaeXga do
  @moduledoc """
  Modulo specifico per trattare i dati esportati da cae_xga in formato csv.
  """

  @in_windows Application.compile_env(:epoa, :windows_share, "./test")

  @doc """
  Directory condivisa in windows raggiungibile da server linux
  """
  def csv_dir do
    "#{@in_windows}/csv_da_xga"
  end

  @doc """
  Tutti i file da elaborare
  """
  def csv_files do
    Path.wildcard("#{csv_dir()}/*.csv")
  end

  def file_anno_mese(file) do
    anno_mese =
      with base <- Path.basename(file),
           ext <- Path.extname(file),
           do: String.replace(base, ext, "")

    anno = String.slice(anno_mese, 0, 4)
    mese = String.slice(anno_mese, 4, 2)
    {file, anno, mese}
  end

  def es_stringa_nome_colonna, do: "P - (12345) Cagliari Stazione"

  @doc """
  Estrai i singoli valori da una stringa_nome_colonna

  decodifica("TIPO - (codice) nome")

  ## Examples

      iex> Arpos.Toolbox.CaeXga.decodifica("I - (32437) Nome Stazione")
      %{codice: "32437", nome: "Nome Stazione", tipo: "I"}

  """
  def decodifica(stringa_nome_colonna) do
    [tipo, numero_nome] = String.split(stringa_nome_colonna, "-")

    [codice, nome] = String.split(numero_nome, ")")

    codice = String.replace(codice, "(", "")

    %{tipo: String.trim(tipo), codice: String.trim(codice), nome: String.trim(nome)}
  end
end
