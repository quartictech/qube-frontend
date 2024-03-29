module Main exposing (..)

import Models exposing (..)
import Msgs exposing (..)
import Navigation exposing (Location)
import Routing
import Views exposing (view_)

import Api exposing (getClients)


---- MODEL ----


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
    ( initialModel currentRoute, getClients)



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    Routing.parseLocation location
            in
            ( { model | route = newRoute }, Cmd.none )

        Msgs.LoadJobs (Ok newClients) ->
            ( { model | clients = newClients }, Cmd.none)

        _ ->
            ( model, Cmd.none )



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { view = view_
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
