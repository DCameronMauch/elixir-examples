# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :web,
  namespace: Umbrella1.Web

# Configures the endpoint
config :web, Umbrella1.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ss1uHQq1d8yKZAUer6/hDg8cNZdcGIGejeHse00fEgd2S+clvQ9O+YpqQnywHN2A",
  render_errors: [view: Umbrella1.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Umbrella1.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
