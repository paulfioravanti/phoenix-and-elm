module RemoteData exposing (RemoteData(..))


type RemoteData e a
    = Failure e
    | NotRequested
    | Requesting
    | Success a
