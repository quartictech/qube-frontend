module Main exposing (..)

import Navigation exposing (Location)

import Models exposing (..)
import Routing
import Msgs exposing (..)
import Views exposing(view_)

---- MODEL ----

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )


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
      _ -> ( model, Cmd.none )


---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { view = view_
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
