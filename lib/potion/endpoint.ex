defmodule Potion.Endpoint do
  use Phoenix.Endpoint, otp_app: :potion

  socket "/", Potion.Socket

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
end
