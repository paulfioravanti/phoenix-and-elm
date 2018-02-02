defmodule PhoenixAndElmWeb.ContactView do
  use PhoenixAndElmWeb, :view

  def render("index.json", %{page: page}), do: page
end
