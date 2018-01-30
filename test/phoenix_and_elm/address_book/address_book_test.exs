defmodule PhoenixAndElm.AddressBookTest do
  use PhoenixAndElm.DataCase

  alias PhoenixAndElm.AddressBook

  describe "contacts" do
    alias PhoenixAndElm.AddressBook.Contact

    @valid_attrs %{
      birth_date: ~D[2010-04-17],
      email: "some email",
      first_name: "some first_name",
      gender: 42,
      headline: "some headline",
      last_name: "some last_name",
      location: "some location",
      phone_number: "some phone_number",
      picture: "some picture"
    }
    @update_attrs %{
      birth_date: ~D[2011-05-18],
      email: "some updated email",
      first_name: "some updated first_name",
      gender: 43,
      headline: "some updated headline",
      last_name: "some updated last_name",
      location: "some updated location",
      phone_number: "some updated phone_number",
      picture: "some updated picture"
    }
    @invalid_attrs %{
      birth_date: nil,
      email: nil,
      first_name: nil,
      gender: nil,
      headline: nil,
      last_name: nil,
      location: nil,
      phone_number: nil,
      picture: nil
    }

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AddressBook.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert AddressBook.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert AddressBook.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} =
               AddressBook.create_contact(@valid_attrs)

      assert contact.birth_date == ~D[2010-04-17]
      assert contact.email == "some email"
      assert contact.first_name == "some first_name"
      assert contact.gender == 42
      assert contact.headline == "some headline"
      assert contact.last_name == "some last_name"
      assert contact.location == "some location"
      assert contact.phone_number == "some phone_number"
      assert contact.picture == "some picture"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               AddressBook.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()

      assert {:ok, contact} =
               AddressBook.update_contact(contact, @update_attrs)

      assert %Contact{} = contact
      assert contact.birth_date == ~D[2011-05-18]
      assert contact.email == "some updated email"
      assert contact.first_name == "some updated first_name"
      assert contact.gender == 43
      assert contact.headline == "some updated headline"
      assert contact.last_name == "some updated last_name"
      assert contact.location == "some updated location"
      assert contact.phone_number == "some updated phone_number"
      assert contact.picture == "some updated picture"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AddressBook.update_contact(contact, @invalid_attrs)

      assert contact == AddressBook.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = AddressBook.delete_contact(contact)

      assert_raise Ecto.NoResultsError, fn ->
        AddressBook.get_contact!(contact.id)
      end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = AddressBook.change_contact(contact)
    end
  end
end
