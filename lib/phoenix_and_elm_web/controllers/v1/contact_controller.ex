defmodule PhoenixAndElmWeb.V1.ContactController do
  use PhoenixAndElmWeb, :controller
  alias PhoenixAndElm.AddressBook

  def index(conn, params) do
    contacts =
      params
      |> Map.get("search", "")
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    json(conn, contacts)
  end

  def show(conn, %{"id" => id}) do
    contact = AddressBook.get_contact!(id)
    json(conn, %{data: %{contact: contact}})
  end
end
