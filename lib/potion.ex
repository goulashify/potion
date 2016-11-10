defmodule Potion do
  @moduledoc "Potion is a simple chat server kata."

  use Application
  alias Potion.Endpoint

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the endpoint when the application starts
      supervisor(Potion.Endpoint, []),
      supervisor(Potion.Channel.Presence, []),
    ]

    opts = [strategy: :one_for_one, name: Potion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
