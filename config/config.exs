# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :postmortem_delivery,
  ecto_repos: [PostmortemDelivery.Repo]

# Configures the endpoint
config :postmortem_delivery, PostmortemDeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M6Wn4LZZLZFHucOHxp+JszOIqcPXEROgbaMmgTf5IeZA7CCjTg4DqhlcZrIaWMrw",
  render_errors: [view: PostmortemDeliveryWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PostmortemDelivery.PubSub,
  live_view: [signing_salt: "PZ6KMkzF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
