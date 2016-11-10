defmodule Potion.Channel.Room do
  use Phoenix.Channel

  require Logger

  # "" <> nickName needed to don't match nil
  def join("room:" <> roomName, %{"nick" => "" <> nickName}, socket) do
    Logger.debug("User joining room #{roomName} with nick: #{nickName}")
    {:ok, assign(socket, :nick, nickName)}
  end

  def join(_room, message, _socket) do
    Logger.warn("User failed to join room, #{inspect(message)}")
    {:error, %{reason: "Room doesn't exist or message is invalid.'"}}
  end

  def handle_in("message", %{"content" => "" <> content}, socket) do
    messageObj = %{"content" => content, "sender" => socket.assigns.nick}
    broadcast!(socket, "message", messageObj)

    {:noreply, socket}
  end

  def handle_in(messageName, messageBody, socket) do
    Logger.warn("Unmatched message with name \"#{messageName}\" with body #{messageBody}.")

    {:reply, {:error, %{reason: "Unmatched call."}}, socket}
  end

end