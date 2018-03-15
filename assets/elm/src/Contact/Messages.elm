module Contact.Messages exposing (Msg(..))

import Contact.Model exposing (Contact)
import Http


type Msg
    = FetchContact (Result Http.Error Contact)
