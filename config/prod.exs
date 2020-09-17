use Mix.Config

config :ressipy, RessipyWeb.Endpoint,
  url: [host: "ressipy.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info
