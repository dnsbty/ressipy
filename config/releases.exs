import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :ressipy, Ressipy.Repo,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :ressipy, RessipyWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :ressipy, RessipyWeb.Endpoint, server: true

message_bird_access_key =
  System.get_env("MESSAGE_BIRD_ACCESS_KEY") ||
    raise """
    environment variable MESSAGE_BIRD_ACCESS_KEY is missing.
    You can get this from the MessageBird dashboard.
    """

config :ressipy, message_bird_access_key: message_bird_access_key

default_phone_number =
  System.get_env("DEFAULT_PHONE_NUMBER") ||
    raise """
    environment variable DEFAULT_PHONE_NUMBER is missing.
    You can get this from the MessageBird dashboard.
    """

config :ressipy, default_phone_number: default_phone_number
