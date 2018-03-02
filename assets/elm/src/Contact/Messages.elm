module Contact.Messages exposing (ContactMsg(..))

import Contact.Model exposing (Contact)
import Http


type ContactMsg
    = FetchContact (Result Http.Error Contact)
