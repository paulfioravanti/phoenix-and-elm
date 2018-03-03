defmodule PhoenixAndElmWeb.ContactChannel do
  @moduledoc false

  use PhoenixAndElmWeb, :channel
  alias PhoenixAndElm.AddressBook
  require Logger

  def join("contacts", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("contacts:fetch", params, socket) do
    contacts = AddressBook.list_contacts(params)
    {:reply, {:ok, contacts}, socket}
  end

  def handle_in("contact:" <> id, _payload, socket) do
    contact = AddressBook.get_contact!(id)
    {:reply, {:ok, contact}, socket}
  rescue
    Ecto.NoResultsError ->
      {:reply, {:error, %{error: "Contact not found"}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
