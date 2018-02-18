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
    Logger.info("Handling contacts...")

    search_query = Map.get(params, "search", "")

    page =
      search_query
      |> AddressBook.search_contacts()
      |> AddressBook.paginate_contacts_by(params, :first_name)

    {:reply, {:ok, page}, socket}
  end

  def handle_in("contact:" <> contact_id, _, socket) do
    Logger.info("Handling contact...")

    contact = AddressBook.get_contact!(contact_id)

    case contact do
      nil ->
        {:reply, {:error, %{error: "Contact no found"}}, socket}

      _ ->
        {:reply, {:ok, contact}, socket}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (contact:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast(socket, "shout", payload)
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
