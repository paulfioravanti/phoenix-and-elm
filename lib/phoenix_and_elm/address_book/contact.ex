defmodule PhoenixAndElm.AddressBook.Contact do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixAndElm.AddressBook.Contact

  @derive {Poison.Encoder, except: [:__meta__, :inserted_at, :updated_at]}

  @genders [
    {0, :male},
    {1, :female}
  ]

  schema "contacts" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:gender, :integer)
    field(:birth_date, :date)
    field(:location, :string)
    field(:phone_number, :string)
    field(:email, :string)
    field(:headline, :string)
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

  @doc """
  Returns genders options
  """
  def genders, do: @genders
end
