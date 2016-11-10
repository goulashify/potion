defmodule Potion.Channel.RoomTest do
  use Potion.ChannelCase
  alias Potion.Channel.Room

  setup do
    nick = "daniel"
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(Room, "room:lobby", %{"nick" => nick})

    {:ok, socket: socket, nick: nick}
  end

  test "socket should not be able to join without defining it's nick" do
    sock = socket(0, %{})
    assert {:error, _} = subscribe_and_join(sock, Room, "room:lobby", %{})
    assert {:error, _} = subscribe_and_join(sock, Room, "room:lobby", %{:nick => "hi"})
    assert {:error, _} = subscribe_and_join(sock, Room, "room:lobby", %{"nick" => nil})
  end

  test "should be able to join with valid request" do
    assert {:ok, _, _} = socket(0, %{}) |> subscribe_and_join(Room, "room:lobby", %{"nick" => "daniel"})
  end

  test "should receive an error when pushing invalid messages", %{socket: socket} do
    push(socket, "message", nil) |> assert_reply(:error)
  end

  test "the sent message should be broadcasted with the sender's nick and the message", %{socket: socket, nick: nick} do
    message = "hi"
    push(socket, "message", %{"content" => message})

    assert_broadcast "message", %{"content" => message, "sender" => nick}
  end
end
