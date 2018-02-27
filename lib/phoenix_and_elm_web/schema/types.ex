defmodule PhoenixAndElmWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias PhoenixAndElm.AddressBook.Contact
  import_types(Absinthe.Type.Custom)

  union :entries do
    @desc "Union object for all paginated things."
    types([:contact])
    resolve_type(fn %Contact{}, _ -> :contact end)
  end

  object :paginated do
    field(:total_entries, :integer)
    field(:total_pages, :integer)
    field(:page_number, :integer)
    field(:page_size, :integer)
    field(:entries, list_of(:entries))
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
end