# General application configuration
use Mix.Config

config :ressipy,
  ecto_repos: [Ressipy.Repo]

# Configures the endpoint
config :ressipy, RessipyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zxWz4SZdhaGNSFxcC5QYhfQxFV7yKpt4JB7rsAxusgY1JMAW5v7D2Ssfw6FPqwO8",
  render_errors: [view: RessipyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ressipy.PubSub,
  live_view: [signing_salt: "nGUAI6xC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
