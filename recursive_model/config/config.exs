# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :recursive_model,
  ecto_repos: [RecursiveModel.Repo]

# Configures the endpoint
config :recursive_model, RecursiveModel.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1PHvX91Axg5ATuHjbI3kZa7xKwU2w03Q4VrwWiG5sufxQ/0m76/ft5KWf7sx13Fj",
  render_errors: [view: RecursiveModel.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RecursiveModel.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
