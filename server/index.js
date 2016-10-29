const koa = require('koa')
const api = require('./api')
const client = require('./client')

const app = koa()

app.use(api.createRoute())
app.use(client.createRoute())

module.exports = app
