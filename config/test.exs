import Config

config :arpos, Arpos.Repo,
  username: System.get_env("SUPACLOUD_DB_USER"),
  password: System.get_env("SUPACLOUD_DB_PASSWORD"),
  hostname: System.get_env("SUPACLOUD_DB_HOST_CARG"),
  database: System.get_env("SUPACLOUD_DB_NAME"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
