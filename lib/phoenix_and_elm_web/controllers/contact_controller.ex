defmodule PhoenixAndElmWeb.ContactController do
  use PhoenixAndElmWeb, :controller
  alias PhoenixAndElm.AddressBook

  def index(conn, params) do
    search_query = Map.get(params, "search", "")

    page =
      search_query
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    render(conn, "index.json", page: page)
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", contact: AddressBook.get_contact!(id))
  end
end
