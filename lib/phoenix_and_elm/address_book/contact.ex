defmodule PhoenixAndElm.AddressBook.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixAndElm.AddressBook.Contact

  schema "contacts" do
    field(:birth_date, :date)
    field(:email, :string)
    field(:first_name, :string)
    field(:gender, :integer)
    field(:headline, :string)
    field(:last_name, :string)
    field(:location, :string)
    field(:phone_number, :string)
    field(:picture, :string)
    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [
      :first_name,
      :last_name,
      :gender,
      :birth_date,
      :location,
      :phone_number,
      :email,
      :headline,
      :picture
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :gender,
      :birth_date,
      :location,
      :phone_number,
      :email,
      :headline,
      :picture
    ])
  end
end
