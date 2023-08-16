defmodule Arpos.Toolbox.CaeXga do
  @moduledoc """
  Modulo specifico per trattare i dati esportati da cae_xga in formato csv.
  """

  alias Explorer, as: Exp
  @in_windows Application.compile_env(:arpos, :windows_share, "./test")

  @doc """
  Directory condivisa in windows raggiungibile da server linux
  """
  def csv_dir do
    "#{@in_windows}/poa/csv_da_xga"
  end

  @doc """
  La lista dei file esportati da CAE tramite il software XGA
  """
  def csv_files do
    Path.wildcard("#{csv_dir()}/*.csv")
  end

  @doc """
  Ricava anno e il mese da nome del file
  ## Examples
      iex> Arpos.Toolbox.CaeXga.file_anno_mese("/windows_share/poa/csv_da_xga/200501.csv")
      {"/windows_share/poa/csv_da_xga/200501.csv", "2005", "01"}
  """
  def file_anno_mese(file) do
    anno_mese =
      with base <- Path.basename(file),
           ext <- Path.extname(file),
           do: String.replace(base, ext, "")

    anno = String.slice(anno_mese, 0, 4)
    mese = String.slice(anno_mese, 4, 2)
    %{"file" => file, "anno" => anno, "mese" => mese}
  end

  @doc """
  Estrai i singoli valori da una "nome_colonna"
  ## Examples

      iex> Arpos.Toolbox.CaeXga.decodifica("I - (32437) Nome Stazione")
      %{codice: "32437", nome: "Nome Stazione", tipo: "I"}
  """
  def decodifica(nome_colonna) do
    [tipo, numero_nome] = String.split(nome_colonna, "-", parts: 2)

    [codice, nome] = String.split(numero_nome, ")")

    codice = String.replace(codice, "(", "")

    %{tipo: String.trim(tipo), sensore: String.trim(codice), nome: String.trim(nome)}
  end

  def colonne_da_csv(file) do
    opts = [delimiter: ";", max_rows: 0, dtypes: [{"Data", :date}, {"Ora", :string}]]

    colonne =
      Exp.DataFrame.from_csv!(file, opts)
      |> Exp.DataFrame.names()
      # Remove le prime 2 colonne -> Data, Ora
      |> Enum.drop(2)

    colonne
  end

  def struttura_files do
    csv_files()
    |> Enum.map(&file_anno_mese/1)
  end

  def record_per_tutti_i_file do
    csv_files()
    |> Enum.map(&record_per_file/1)
    |> List.flatten()
  end

  def record_per_file(file) do
    IO.inspect(file, label: "file")
    %{"file" => file, "anno" => anno, "mese" => mese} = file_anno_mese(file)
    colonne = colonne_da_csv(file)
    anno_mese = %{"anno" => anno, "mese" => mese}
    Enum.map(colonne, fn c -> Map.merge(anno_mese, decodifica(c)) end)
  end
end
