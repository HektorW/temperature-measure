require('./index.html')
const Elm = require('./elm/Main.elm')

Elm.Main.embed(document.getElementById('elm-app'))