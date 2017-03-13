const Koa = require('koa')
const api = require('./api')
const client = require('./client')

const app = new Koa()

app.use(api.createRoute())
app.use(client.createRoute())

module.exports = app
