require('offline-plugin/runtime').install()

require('./css/main.css')
require('./index.html')

const Elm = require('./elm/Main.elm')
Elm.Main.embed(document.getElementById('elm-app'))
