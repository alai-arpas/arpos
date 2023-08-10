defmodule CaeXgaTest do
  use ExUnit.Case

  alias Arpos.Toolbox.CaeXga, as: Xga

  doctest Arpos.Toolbox.CaeXga

  test "trova i file csv" do
    file = [
      "test/poa/csv_da_xga/200512.csv",
      "test/poa/csv_da_xga/200601.csv",
      "test/poa/csv_da_xga/200612.csv",
      "test/poa/csv_da_xga/200701.csv"
    ]

    assert Xga.csv_files() == file
  end

  test "prima colonna" do
    prima_colonna = Xga.colonne_da_csv("test/poa/csv_da_xga/200512.csv") |> hd
    assert prima_colonna == "I - (32432) Flumini Uri a San Vito"
  end
end
