module Msgs exposing (..)

import Material
import Navigation exposing (Location)


type Msg
    = Mdl (Material.Msg Msg)
    | OnLocationChange Location
    | MyClickMsg
