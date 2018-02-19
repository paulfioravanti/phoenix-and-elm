defmodule PhoenixAndElm.AddressBook.Query do
  import Ecto.Query, warn: false
  alias PhoenixAndElm.AddressBook.Contact

  def search_contacts(query) do
    Contact
    |> where(
      fragment(
        """
        (to_tsvector(
          'english',
          coalesce(first_name, '') || ' ' ||
          coalesce(last_name, '') || ' ' ||
          coalesce(location, '') || ' ' ||
          coalesce(headline, '') || ' ' ||
          coalesce(email, '') || ' ' ||
          coalesce(phone_number, '')
        ) @@ to_tsquery('english', ?))
        """,
        ^query
      )
    )
  end
end
