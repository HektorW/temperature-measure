const koaRouter = require('koa-router')
const compose = require('koa-compose')
const { read } = require('../../measurement/storage')

function* getTemperature() {
  const { query } = this
  const count = query.count || 1
  const start = query.start || 0
  this.body = yield read(count, start)
}

function* noFlowThrough(next) {
  const apiRegex = /^\/api/i
  if (apiRegex.test(this.path) !== true) {
    yield next
  }
}

module.exports.createRoute = function createRoute() {
  const router = koaRouter()

  router.get('/api/temperature', getTemperature)

  return compose([
    router.routes(),
    router.allowedMethods(),
    noFlowThrough,
  ])
}
