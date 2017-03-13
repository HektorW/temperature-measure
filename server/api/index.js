const koaRouter = require('koa-router')
const compose = require('koa-compose')
const { read } = require('../../measurement/storage')

async function getTemperature(ctx) {
  const { query } = ctx
  const count = query.count || 1
  const start = query.start || 0
  const entries = await read(count, start)
  ctx.body = entries.map(
    ({ time, temperature, location }) => ({ time, temperature, location })
  )
}

async function checkApi404(ctx, next) {
  const apiRegex = /^\/api/i
  if (apiRegex.test(ctx.path) !== true) {
    await next
  }
}

module.exports.createRoute = function createRoute() {
  const router = koaRouter()

  router.get('/api/temperature', getTemperature)

  return compose([
    router.routes(),
    router.allowedMethods(),
    checkApi404,
  ])
}
