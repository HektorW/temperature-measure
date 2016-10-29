const config = require('./config')
const env = require('./config/env')
const server = require('./server')
const measurement = require('./measurement')
const log = require('./log')('root')

log.info({ config, env }, 'Booting app')

server.listen(config.port, () => log.info({ port: config.port }, 'Server started!'))
measurement.start(config.measurementInterval)
