defmodule PhoenixAndElmWeb.LayoutView do
  use PhoenixAndElmWeb, :view

  @default_socket_url "ws://localhost:4000/socket/websocket"

  def socket_url do
    System.get_env("WEBSOCKET_URL") || @default_socket_url
  end
end
