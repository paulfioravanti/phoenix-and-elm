defmodule PhoenixAndElmWeb.Schema do
  use Absinthe.Schema
  alias PhoenixAndElmWeb.ContactResolver
  import_types(PhoenixAndElmWeb.Schema.Types)

  query do
    @desc "The list of contacts in the address book"
    field :contacts, type: :paginated do
      @desc "The page number for pagination"
      arg(:page, :integer)
      @desc "The query for searching contacts"
      arg(:search, :string)
      resolve(&ContactResolver.search_contacts/3)
    end

    field :contact, type: :contact do
      @desc "The contact ID"
      arg(:id, non_null(:id))
      resolve(&ContactResolver.get_contact/3)
    end
  end
end
