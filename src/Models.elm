module Models exposing (..)

import Material


type alias Job =
    { id : String
    , client : String
    , name : String
    , createSpec : String
    , startTime : Int
    , endTime : Int
    }


defaultJobs : List Job
defaultJobs =
    [ { id = "0", client = "noob", name = "Noob", createSpec = "{}", startTime = 0, endTime = 0 }
    , { id = "0", client = "noob", name = "Noob", createSpec = "{}", startTime = 0, endTime = 0 }
    ]


type alias Model =
    { mdl : Material.Model
    , jobs : List Job
    , clients: List String
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { mdl = Material.model
    , jobs = defaultJobs
    , clients = []
    , route = route
    }


type alias JobId =
    String


type Route
    = HomeRoute
    | JobRoute JobId
    | NotFoundRoute
