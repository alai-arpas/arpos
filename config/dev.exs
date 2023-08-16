import Config

config :arpos, :windows_share, System.get_env("WINDOWS_SHARE")
config :arpos, :oracle_rest_url, System.get_env("ORACLE_REST_URL")

config :logger, :console,
  format: "[$level] $message $metadata\n",
  metadata: [:error_code, :file, :line],
  level: :debug,
  handle_otp_reports: true,
  handle_sasl_reports: true

config :arpos, :ecto_repos, [Arpos.RepoOra]

config :arpos, Arpos.RepoOra,
  username: System.get_env("SASSAPI_DB_user"),
  password: System.get_env("SASSAPI_DB_pw"),
  database: System.get_env("SASSAPI_DB_service_name"),
  hostname: System.get_env("SASSAPI_DB_host"),
  port: System.get_env("SASSAPI_DB_port")

config :arpos, Arpos.Repo,
  username: System.get_env("SUPACLOUD_DB_USER"),
  password: System.get_env("SUPACLOUD_DB_PASSWORD"),
  hostname: System.get_env("SUPACLOUD_DB_HOST_CARG"),
  database: System.get_env("SUPACLOUD_DB_NAME"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# config :arpos, Arpos.Repo, migration_default_prefix: "andrea_decidere"
# config :arpos, Arpos.Repo, migration_primary_key: [name: :id, prefix: :music_db]
