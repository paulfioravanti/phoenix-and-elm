defmodule PhoenixAndElmWeb.ContactResolver do
  @moduledoc false

  alias PhoenixAndElm.AddressBook

  def list_contacts(_parent, args, _resolution) do
    contacts = AddressBook.list_contacts(args)
    {:ok, contacts}
  end

  def get_contact(_parent, %{id: id}, _resolution) do
    contact = AddressBook.get_contact!(id)
    {:ok, contact}
  end
end
