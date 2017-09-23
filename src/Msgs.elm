module Msgs exposing (..)

import Material
import Navigation exposing (Location)
import Http
import Result


type Msg
    = Mdl (Material.Msg Msg)
    | OnLocationChange Location
    | MyClickMsg
    | LoadJobs (Result Http.Error (List String))
