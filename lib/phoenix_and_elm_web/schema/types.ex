defmodule PhoenixAndElmWeb.Schema.Types do
  @moduledoc false

  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  @desc "A set of paginated contacts, including pagination metadata"
  object :contact_list do
    @desc "The total number of entries"
    field(:total_entries, :integer)
    @desc "The total number of paginated pages"
    field(:total_pages, :integer)
    @desc "The current page number"
    field(:page_number, :integer)
    @desc "The number of paginated items per page"
    field(:page_size, :integer)
    @desc "The list of paginated items"
    field(:entries, list_of(:contact))
  end

  @desc "An address book contact"
  object :contact do
    @desc "Contact identifier"
    field(:id, :integer)
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
