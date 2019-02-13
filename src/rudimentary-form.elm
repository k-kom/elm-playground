import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view}


-- MODEL
type alias Model = 
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  }

init : Model
init =
  Model "" "" "" ""


-- UPDATE

-- これは union type desu
type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
          { model | name = name }

        Password password ->
          { model | password = password }

        PasswordAgain password ->
          { model | passwordAgain = password }

        Age age ->
          { model | age = age }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "text" "Age" model.age Age
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]

-- 四つ目の引数は Msg のどれかがほしい、 と言っています
viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

-- TODO: ここはバリデーションは全部やって div 内に列挙するようにしたいです
--       ので個別のバリデーション関数はエラーメッセージを返してくれると嬉しいです
viewValidation : Model -> Html msg
viewValidation model =
  if model.password /= model.passwordAgain then
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else if String.length model.password < 9 then
    div [ style "color" "red" ] [ text "Too short password!" ]
  else if invalidateAge model then
    div [ style "color" "red" ] [ text "Age should be a number!" ]
  else
    div [ style "color" "green" ] [ text "OK" ]

invalidateAge : Model -> Bool
invalidateAge model =
    case String.toInt model.age of
        Just _ -> False
        _ -> True
            
