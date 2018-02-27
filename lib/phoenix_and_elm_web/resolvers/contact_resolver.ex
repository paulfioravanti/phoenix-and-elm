defmodule PhoenixAndElmWeb.ContactResolver do
  alias PhoenixAndElm.AddressBook

  def search_contacts(_, params, _) do
    contacts =
      params
      |> Map.get(:search, "")
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    {:ok, contacts}
  end

  def get_contact(_, %{id: id}, _) do
    {:ok, AddressBook.get_contact!(id)}
  end
end
