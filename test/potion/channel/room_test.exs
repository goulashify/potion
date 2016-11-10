defmodule Potion.Channel.RoomTest do
  use Potion.ChannelCase
  alias Potion.Channel.Room

  setup do
    nick = "daniel"
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(Room, "room:lobby", %{"nick" => nick})

    assert_push("presence_state", _) #asserted presence_state push for the first (setup) user
    assert_push("presence_diff", _) #asserted presence_diff push for the first (setup) user
    {:ok, socket: socket, nick: nick}
  end

  describe "joining" do
    test "socket should not be able to join without defining it's nick" do
      sock = socket(0, %{})
      assert {:error, _} = subscribe_and_join(sock, Room, "room:lobby", %{})
      assert {:error, _} = subscribe_and_join(sock, Room, "room:lobby", %{:nick => "hi"})
      assert {:error, _} = subscribe_and_join(sock, Room, "room:lobby", %{"nick" => nil})
    end

    test "should be able to join with valid request" do
      assert {:ok, _, _} = socket(0, %{}) |> subscribe_and_join(Room, "room:lobby", %{"nick" => "daniel"})
    end
  end

  describe "message" do
    test "should receive an error when pushing invalid messages", %{socket: socket} do
      push(socket, "message", nil) |> assert_reply(:error)
    end

    test "the sent message should be broadcasted with the sender's nick and the message", %{socket: socket, nick: nick} do
      message = "hi"
      push(socket, "message", %{"content" => message})

      assert_broadcast "message", %{"content" => ^message, "sender" => ^nick}
    end
  end

  describe "presence" do
    test "should send a list of participants when joined", %{nick: nick_of_setup_user} do
      socket("user_id2", %{}) |> subscribe_and_join(Room, "room:lobby", %{"nick" => "dani"})
      assert_push("presence_state", %{^nick_of_setup_user => _}) #the second one received the setup user's presence
    end

    test "should broadcast the event of user leave and enter" do
      nick = "dani"
      socket("user_id2", %{}) |> subscribe_and_join(Room, "room:lobby", %{"nick" => nick})

      assert_broadcast("presence_diff", %{joins: %{^nick => _}}) #assert that user "dani" is in the join
    end
  end
end
