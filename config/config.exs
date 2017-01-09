# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sebastian,
  ecto_repos: [Sebastian.Repo]

# Configures the endpoint
config :sebastian, Sebastian.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xvi8UTX3KpYUY+N3lK3m+MzDs1p30mMqB+eWfAxbErcptewNABBgIJhxrzHVlauW",
  render_errors: [view: Sebastian.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sebastian.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Sebastian",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "w3A7N/+OuvCHLPC09r/XAtojeXfWYOrRFC7ttZAsW0ZJavMw1ffo1s5ZwIzY7Lbk",
  serializer: Sebastian.GuardianSerializer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
