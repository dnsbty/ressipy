use Mix.Config

config :ressipy, Ressipy.Web.Endpoint,
  version: Mix.Project.config[:version],
  on_init: {Ressipy.Web.Endpoint, :load_from_system_env, []},
  url: [host: "new.ressipy.com"],
  http: [port: 3663],
  root: ".",
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

config :phoenix, :serve_endpoints, true

# Basic db configuration that can be overwritten in imported config
config :ressipy, Ressipy.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ressipy_prod",
  hostname: "localhost",
  pool_size: 10

# Finally import any environment specific configuration
import_config "/var/apps/ressipy/*.exs"
