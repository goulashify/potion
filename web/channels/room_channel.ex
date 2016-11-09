defmodule SummaMeetings.RoomChannel do
  use Phoenix.Channel

  require Logger

  def join("room:" <> roomName, %{"nick" => nickName}, socket) do
    Logger.debug "User joining room #{roomName} with nick: #{nickName}"
    {:ok, assign(socket, :nick, nickName)}
  end

  def join(_room, message, _socket) do
    Logger.error "User failed to join room, #{inspect(message)}"
    {:error, %{reason: "Room doesn't exist or message is invalid.'"}}
  end

  def handle_in("message", %{"content" => content}, socket) do
    messageObj = %{"content" => content, "sender" => socket.assigns.nick}
    broadcast!(socket, "message", messageObj)
    {:noreply, socket}
  end

  def handle_in(messageName, messageBody, socket) do
    Logger.error("Unmatched message with name \"#{messageName}\" with body #{messageBody}.")
    {:error, %{reason: "Unmatched call."}}
  end
  
end