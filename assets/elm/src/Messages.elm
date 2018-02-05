module Messages exposing (..)

-- import Http
-- import Model exposing (ContactList, Contact)

import Json.Encode as JE
import Navigation
import Routing exposing (Route)


type
    Msg
    -- = FetchResult (Result Http.Error ContactList)
    = FetchSuccess JE.Value
    | FetchError JE.Value
    | Paginate Int
    | HandleSearchInput String
    | HandleFormSubmit
    | ResetSearch
    | UrlChange Navigation.Location
    | NavigateTo Route
      -- | FetchContactResult (Result Http.Error Contact)
    | FetchContactSuccess JE.Value
    | FetchContactError JE.Value
