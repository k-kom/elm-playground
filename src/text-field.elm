import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view}

-- MODEL
type alias Model =
  { content : String
  }

-- model を record で定義するとフレキシビリティがあってよい
init : Model
init =
  { content = "" }

-- UPDATE
type Msg
    = Change String -- Change : String -> Msg の省略?


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


view : Model -> Html Msg
view model =
    div []
      [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
      , div [] [ text (String.reverse model.content) ]
      ]