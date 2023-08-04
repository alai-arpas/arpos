import Config

config :arpos, :ecto_repos, [Arpos.Repo]

config :arpos, Arpos.Repo,
  username: System.get_env("ARPAGEO_DB_USER"),
  password: System.get_env("ARPAGEO_DB_PASSWORD"),
  database: "arpos",
  hostname: System.get_env("ARPAGEO_DB_HOST"),
  # this is not normally needed - we put it here to support an example of
  migration_lock: nil

# creating an index with the `concurrently` option set to true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
