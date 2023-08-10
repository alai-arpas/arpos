defmodule CaeXgaTest do
  use ExUnit.Case

  alias Arpos.Toolbox.CaeXga, as: Xga

  doctest Arpos.Toolbox.CaeXga

  test "trova i file csv" do
    file = [
      "test/csv_da_xga/200512.csv",
      "test/csv_da_xga/200601.csv",
      "test/csv_da_xga/200612.csv",
      "test/csv_da_xga/200701.csv"
    ]

    assert Xga.csv_files() == file
  end
end
