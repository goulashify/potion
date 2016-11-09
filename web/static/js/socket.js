// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"
import $ from "jquery";

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
const roomName = prompt("Room name");
const nick = prompt("nick");
// const roomName = "roomanmeqkwdkqwd";
// const nick = "danilel";
let channel = socket.channel(`room:${roomName}`, {nick: nick})
// let channel = socket.channel(`room:asd`, {nick: "dani"})
channel.join()
  .receive("ok", resp => {
      console.log("Joined successfully", resp)
      $(".panel-heading").html(`Connected to room #${roomName} with user ${nick}`);
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("message", (msg) => {
    let {sender, content} = msg;
    let htmlStuff = `<div class="row message-bubble"><p class="text-muted">${sender}</p><span>${content}</span></div>`;
    $(".message-container").append(htmlStuff);
});

const $textField = $(".message-text-field");
$textField.on("keypress", ({charCode} = event) => {
    if(charCode !== 13) return;
    channel.push("message", {content: $textField.val()})
    $textField.val("");
});

window.lofasz = channel;
export default socket
