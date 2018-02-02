defmodule PhoenixAndElmWeb.ContactController do
  use PhoenixAndElmWeb, :controller
  alias PhoenixAndElm.AddressBook

  def index(conn, params) do
    page =
      params
      |> AddressBook.paginate_contacts_by(:first_name)

    render(conn, "index.json", page: page)
  end
end
