module Views exposing (..)

import Html exposing (Html, text, div, img, h1, a, i, img)
import Html.Attributes exposing (class, href, src)
import Html.Attributes exposing (src, style)

import Material.Layout as Layout
import Material.Scheme as Scheme
import Material.Color as Color
import Material.Button as Button
import Material.Icon as Icon
import Material.Options as Options
import Material.Table as Table

import Models exposing (..)
import Msgs exposing (..)

logo: Html Msg
logo =
    img
        [ style [ ( "height" , "65px" ) , ( "margin-right" , "10px" ) , ( "margin-top" , "-10px" ) ], src "quartic.svg" ]
        []

header: Model -> List (Html Msg)
header model = [
  h1
     [ style [ ("padding" , "15px") , ("text-align", "left") , ( "margin" , "0px" ) ] ]
     [ logo
     , text "Qube Console"]
  ]

jobLink: String -> Html Msg
jobLink id =
    a
      [ class "btn regular"
      , href ("#/job/" ++ id)
      ]
      [ i [ class "fa fa-pencil mr1" ] [], text id ]

jobsTable: Model -> Html Msg
jobsTable model =
    div
      [ style [ ( "padding", "20px" ) ] ]
      [
         Table.table []
        [ Table.thead []
          [ Table.tr []
            [ Table.th [] [ text "Id" ]
            , Table.th [] [ text "Client" ]
            , Table.th [] [ text "Name" ]
            , Table.th [] [ text "Create Spec" ]
            , Table.th [] [ text "Start Time" ]
            , Table.th [] [ text "End Time" ]
            ]
          ]
        , Table.tbody []
            (model.jobs |> List.map (\job ->
               Table.tr []
                 [ Table.td [] [ jobLink job.id ]
                 , Table.td [] [ text job.client ]
                 , Table.td [] [ text job.name ]
                 , Table.td [] [ job.createSpec |> toString |> text ]
                 , Table.td [] [ job.startTime |> toString |> text ]
                 , Table.td [] [ job.endTime |> toString |> text ]
                 ]
               )
            )
        ]

      ]

refreshButton : Model -> Html Msg
refreshButton model =
    div
      [ style [ ( "float", "right" ) , ( "padding" , "20px" ) ] ]
      [ Button.render Mdl [0] model.mdl
        [ Button.fab
          , Button.colored
          , Options.onClick MyClickMsg
        ]
        [ Icon.i "cached"]
      ]

view : Model -> Html Msg
view model =
    div
        [ style [ ( "display" , "flex" ) , ( "flex-direction" , "column" ) ] ]
        [ div
            []
            [ refreshButton model , jobsTable model ]
        ]

view_ : Model -> Html Msg
view_ model =
    div []
    [ Scheme.topWithScheme Color.Pink Color.DeepPurple
      (Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = header model
        , drawer = []
        , tabs =  ([], [])
        , main = [ div [] [page model] ]
        }
      )
    ]

notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]

jobView : JobId -> Html msg
jobView id =
    div []
        [ id |> text
        ]



page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            view model

        Models.JobRoute id ->
          jobView id

        Models.NotFoundRoute ->
          notFoundView

