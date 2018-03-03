defmodule PhoenixAndElmWeb.ContactResolver do
  alias PhoenixAndElm.AddressBook

  def search_contacts(_, params, _) do
    contacts = AddressBook.list_contacts(params)
    {:ok, contacts}
  end

  def get_contact(_, %{id: id}, _) do
    contact = AddressBook.get_contact!(id)
    {:ok, contact}
  end
end
