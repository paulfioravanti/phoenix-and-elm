defmodule PhoenixAndElmWeb.V1.ContactController do
  use PhoenixAndElmWeb, :controller
  alias PhoenixAndElm.AddressBook

  def index(conn, params) do
    search_query = Map.get(params, "search", "")

    page =
      search_query
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    json(conn, page)
  end

  def show(conn, %{"id" => id}) do
    json(conn, AddressBook.get_contact!(id))
  end
end
