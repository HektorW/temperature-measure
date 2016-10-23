const co = require('co')
const { getRawOutput, parseTemperature } = require('./sensor')
const { write } = require('./storage')
const { sensorLocation: location } = require('../config')

function sample() {
  co(function* () {
    const rawOutput = yield getRawOutput()
    const temperature = parseTemperature(rawOutput)
    write({ rawOutput, temperature, location })
  })
}

module.exports.start = function start(measurementInterval) {
  sample()
  setInterval(sample, measurementInterval)
}
