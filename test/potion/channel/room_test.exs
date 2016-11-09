defmodule Potion.Channel.RoomTest do
  use Potion.ChannelCase
  alias Potion.Channel.Room

  setup do
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(Room, "room:lobby", %{"nick" => "daniel"})

    {:ok, socket: socket}
  end

  test "socket is not able to join with " do

  end

#  test "ping replies with status ok", %{socket: socket} do
#    ref = push socket, "ping", %{"hello" => "there"}
#    assert_reply ref, :ok, %{"hello" => "there"}
#  end
#
#  test "shout broadcasts to room:lobby", %{socket: socket} do
#    push socket, "shout", %{"hello" => "all"}
#    assert_broadcast "shout", %{"hello" => "all"}
#  end
#
#  test "broadcasts are pushed to the client", %{socket: socket} do
#    broadcast_from! socket, "broadcast", %{"some" => "data"}
#    assert_push "broadcast", %{"some" => "data"}
#  end
end
