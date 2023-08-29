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

  def csv_dir_punto, do: "#{@in_windows}/poa/csv_da_xga_PUNTO"

  @doc """
  Copia tutti i file da "csv_xga" a "csv_xga_PUNTO"
  sostituendo la "," col "." in maniera asincrona
  """
  def copia_tutto(files, pid, sovrascrivi \\ false) do
    files
    |> Enum.each(fn file -> spawn(fn -> sostituisci_virgola_punto(file, pid, sovrascrivi) end) end)
  end

  defp file_in_out(file) do
    nome_no_path_no_csv = Path.basename(file, ".csv")
    file_out = Path.join(csv_dir_punto(), "#{nome_no_path_no_csv}_punto.csv")

    {file, file_out}
  end

  @doc """
  Sostituisce la virgola "," con il "." punto
  """
  def sostituisci_virgola_punto(file, pid, sovrascrivi \\ false) do
    {file_in, file_out} = file_in_out(file)

    if File.exists?(file_out) do
      if sovrascrivi do
        elabora_e_scrivi(:sovrascritto, file_in, file_out, pid)
      else
        send(pid, {:esiste, file_out})
      end
    else
      # non esiste, puoi scrivere
      elabora_e_scrivi(:scritto, file_in, file_out, pid)
    end
  end

  defp elabora_e_scrivi(msg, file_in, file_out, pid) do
    contenuto_virgola = File.read!(file_in)
    contenuto_punto = String.replace(contenuto_virgola, ",", ".")
    res = File.write!(file_out, contenuto_punto)
    send(pid, {msg, file_out, res})
  end

  @doc """
  La lista dei file esportati da CAE tramite il software XGA
  """
  def csv_files do
    Path.wildcard("#{csv_dir()}/*.csv")
  end

  @doc """
  La lista dei file esportati da CAE tramite il software XGA
  Elixir explorer ha problemi con la "," virgola
  """
  def csv_files_punto do
    Path.wildcard("#{csv_dir_punto()}/*.csv")
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
    # |> Enum.take(2)
    |> Enum.map(&record_per_file/1)
    |> List.flatten()
  end

  def record_per_file(file) do
    IO.inspect(file, label: "file")
    %{"file" => file, "anno" => anno, "mese" => mese} = file_anno_mese(file)
    colonne = colonne_da_csv(file)
    anno_mese = %{anno: anno, mese: mese}
    Enum.map(colonne, fn colonna -> Map.merge(anno_mese, decodifica(colonna)) end)
  end
end
