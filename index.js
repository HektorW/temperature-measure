const config = require('./config')
// const server = require('./server')
const measurement = require('./measurement')
const log = require('./log')('root')

log.info({ config }, 'Booting app')

// server.listen(config.port, () => log.info({ port: config.port }, 'Server started!'))
measurement.start(config.measurementInterval)
