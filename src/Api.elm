module Api exposing (..)

import Msgs exposing (..)
import Http
import Json.Decode exposing (..)

getClients: Cmd Msg
getClients = 
  let
    url = "/api/clients"
    request = Http.get url decodeClients
  in
    Http.send LoadJobs request

decodeClients: Decoder (List String)
decodeClients = list string
