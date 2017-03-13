const { join } = require('path')
const serve = require('koa-static')
const { DEVELOPMENT } = require('../../config/env')

function redirectToDevServer(ctx) {
  ctx.response.redirect('http://localhost:3000')
}

const serveClient = serve(join(__dirname, '../../client/dist'))

module.exports.createRoute = function createRoute() {
  if (DEVELOPMENT) {
    return redirectToDevServer
  } else {
    return serveClient
  }
}
