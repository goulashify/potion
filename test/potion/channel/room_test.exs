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

  test "should be able to join with proper nick definition" do
    assert {:ok, _, _} = socket(0, %{}) |> subscribe_and_join(Room, "room:lobby", %{"nick" => "daniel"})
  end

   #test for reply and error
#  test "shouldnt be able to send without the key content", %{socket: socket, nick: nick} do
#    push(socket, "message", nil) |> assert_reply({:stop, _})
#  end

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
