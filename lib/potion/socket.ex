defmodule Potion.Socket do
  @moduledoc "Socket configuration for Potion."

  use Phoenix.Socket

  ## Channels
  channel "room:*", Potion.Channel.Room

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
