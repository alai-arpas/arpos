import Config

config :arpos, :oracle_rest_url, System.get_env("ORACLE_REST_URL")

import_config "#{Mix.env()}.exs"
