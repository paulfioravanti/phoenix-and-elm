defmodule PhoenixAndElmWeb.Schema do
  use Absinthe.Schema
  alias PhoenixAndElm.AddressBook

  # scalar :date do
  #   parse(fn input ->
  #     case Date.from_iso8601(input.value) do
  #       {:ok, date} ->
  #         {:ok, date}

  #       _ ->
  #         :error
  #     end
  #   end)

  #   serialize(fn input ->
  #     Date.to_iso8601(date)
  #   end)
  # end

  query do
    @desc "The list of contacts in the address book"
    field :contacts, list_of(:contact) do
      resolve(fn _, _, _ ->
        {:ok, AddressBook.list_contacts()}
      end)
    end
  end

  object :contact do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:gender, :integer)
    # field(:birth_date, :date)
    field(:location, :string)
    field(:phone_number, :string)
    field(:email, :string)
    field(:headline, :string)
    field(:picture, :string)
  end
end
