const koa = require('koa')
const app = koa()
const getTemperature = require('./getTemperature')

app.use(function *() {
  const temperature = yield getTemperature()
  this.body = `temperature: ${temperature}`
})

app.listen(8080, () => {
  console.log('Server started')
})

