# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :summa_meetings,
  ecto_repos: [SummaMeetings.Repo]

# Configures the endpoint
config :summa_meetings, SummaMeetings.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0IhWOnamyy21MJf5AHezqbAJTHyLhUBl+wupV00ZiorjiO6mWPg62AEUxMxOO1PA",
  render_errors: [view: SummaMeetings.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SummaMeetings.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
