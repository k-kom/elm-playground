import Html exposing (Html, button, div, text)
import Browser
import Html.Events exposing (onClick)

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model = Int

init : Model
init =
  0

-- UPDATE
-- definition of a set of messages that we will get from the UI
type Msg = Increment | Decrement | Reset

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
          model + 1
        
        Decrement ->
          model - 1

        Reset ->
          0

-- VIEW
view : Model -> Html Msg
-- html element function takes
--    1) list of attrs
--    2) a list of child nodes
view model =
   div []
     [ button [ onClick Decrement ] [ text "-" ]
     , div [] [ text (String.fromInt model) ]
     , button [ onClick Increment ] [ text "+" ]
     , div [] [ button [ onClick Reset ] [ text "RESET!" ]]
     ] 