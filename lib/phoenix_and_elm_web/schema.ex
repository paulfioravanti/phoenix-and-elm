defmodule PhoenixAndElmWeb.Schema do
  use Absinthe.Schema
  alias PhoenixAndElm.AddressBook.Contact
  alias PhoenixAndElmWeb.Resolvers
  import_types(Absinthe.Type.Custom)

  query do
    @desc "The list of contacts in the address book"
    # field :contacts, list_of(:contact) do
    field :contacts, type: :pagination do
      arg(:page, :integer)
      arg(:page_size, :integer)
      arg(:search, :string)
      resolve(&Resolvers.Contact.list_contacts/3)
    end
  end

  object :contact do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:gender, :integer)
    field(:birth_date, :date)
    field(:location, :string)
    field(:phone_number, :string)
    field(:email, :string)
    field(:headline, :string)
    field(:picture, :string)
  end

  union :entries do
    @desc "Union object for all paginated things."
    types([:contact])
    resolve_type(fn %Contact{}, _ -> :contact end)
  end

  object :pagination do
    field(:total_entries, :integer, description: "")
    field(:total_pages, :integer, description: "")
    field(:page_number, :integer, description: "")
    field(:page_size, :integer, description: "")
    field(:entries, list_of(:entries))
  end
end
