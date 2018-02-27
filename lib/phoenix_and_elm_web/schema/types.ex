defmodule PhoenixAndElmWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias PhoenixAndElm.AddressBook.Contact
  import_types(Absinthe.Type.Custom)

  @desc "A paginated set of entries from a database"
  union :entries do
    @desc "Union object for all paginated things."
    types([:contact])
    resolve_type(fn %Contact{}, _ -> :contact end)
  end

  @desc "A set of paginated items, including pagination metadata"
  object :paginated do
    @desc "The total number of entries"
    field(:total_entries, :integer)
    @desc "The total number of paginated pages"
    field(:total_pages, :integer)
    @desc "The current page number"
    field(:page_number, :integer)
    @desc "The number of paginated items per page"
    field(:page_size, :integer)
    @desc "The list of paginated items"
    field(:entries, list_of(:entries))
  end

  @desc "An address book contact"
  object :contact do
    @desc "Contact identifier"
    field(:id, :id)
    @desc "Contact first name"
    field(:first_name, :string)
    @desc "Contact last name"
    field(:last_name, :string)
    @desc "Contact gender"
    field(:gender, :integer)
    @desc "Contact birth date"
    field(:birth_date, :date)
    @desc "Contact current location"
    field(:location, :string)
    @desc "Contact phone number"
    field(:phone_number, :string)
    @desc "Contact email"
    field(:email, :string)
    @desc "Contact headline"
    field(:headline, :string)
    @desc "Contact picture"
    field(:picture, :string)
  end
end
