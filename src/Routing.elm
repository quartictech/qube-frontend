module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (JobId, Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map JobRoute (s "job" </> string)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


jobPath : JobId -> String
jobPath id =
  "#/job/" ++ id
