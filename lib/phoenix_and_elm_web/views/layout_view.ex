defmodule PhoenixAndElmWeb.LayoutView do
  use PhoenixAndElmWeb, :view

  def socket_url do
    System.get_env("WEBSOCKET_URL") || "ws://localhost:4000/socket/websocket"
  end
end
