defmodule PhoenixAndElmWeb.ContactResolver do
  alias PhoenixAndElm.AddressBook

  def search_contacts(_, %{search: query} = params, _) do
    contacts =
      query
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    {:ok, contacts}
  end

  def search_contacts(_, _, _) do
    {:ok, AddressBook.list_contacts()}
  end

  def get_contact(_, %{id: id}, _) do
    {:ok, AddressBook.get_contact!(id)}
  end
end
