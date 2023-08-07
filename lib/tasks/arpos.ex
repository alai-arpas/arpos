defmodule Mix.Tasks.Arpos do
  use Mix.Task

  @shortdoc "Gestione versione Arpos"

  @moduledoc """
  Prints Arpos tasks and their information.
      $ mix Arpos
  To print the Arpos version, pass `-v` or `--version`, for example:
      $ mix Arpos --version
  """

  @version Mix.Project.config()[:version]

  @impl true
  @doc false
  def run([opzione]) when opzione in ~w(-v --version) do
    Mix.shell().info("Arpos v#{@version}")
  end

  @impl true
  @doc false
  def run([opzione]) when opzione in ~w(-awv --allinea) do
    old = File.read!("VERSION")
    new_version = "v#{@version}"
    File.write!("VERSION", new_version)
    modifica_readme(old)
    Mix.shell().info("VERSION era #{old} -> Arpos #{new_version}")
  end

  @impl true
  @doc false
  def run([opzione]) when opzione in ~w(-a --app) do
    Mix.shell().info("App Arpos v#{@version}")
  end

  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise("Invalid arguments, expected: mix Arpos")
    end
  end

  defp general() do
    Application.ensure_all_started(:Arpos)
    Mix.shell().info("Gestione versione")
    Mix.shell().info("Arpos v#{Application.spec(:Arpos, :vsn)}")
    Mix.shell().info("\n## Options\n")
    Mix.shell().info("-v, --version        # Prints     Arpos version\n")
    Mix.shell().info("-awv DO NOT USE      # Allinea    Arpos version\n")
    Mix.Tasks.Help.run(["--search", "arpos."])
  end

  defp modifica_readme(da_version) do
    v_elimnata = String.slice(da_version, 1, 50)
    IO.inspect(v_elimnata, label: "v_eliminata")
    con_readme = File.read!("README.md")
    new_version = String.replace(con_readme, v_elimnata, @version)
    File.write!("README.md", new_version)
    Mix.shell().info("Modificato README.md")
  end
end
