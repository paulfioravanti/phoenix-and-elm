defmodule PhoenixAndElmWeb.Resolvers.Contact do
  alias PhoenixAndElm.AddressBook

  def list_contacts(_, %{search: query} = params, _) do
    contacts =
      query
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    {:ok, contacts}
  end

  def list_contacts(_, _, _) do
    {:ok, AddressBook.list_contacts()}
  end
end
