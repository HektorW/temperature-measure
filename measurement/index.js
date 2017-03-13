const { getRawOutput, parseTemperature } = require('./sensor')
const { write } = require('./storage')
const { sensorLocation: location } = require('../config')

async function sample() {
  const rawOutput = await getRawOutput()
  const temperature = parseTemperature(rawOutput)
  write({ rawOutput, temperature, location })
}

module.exports.start = function start(measurementInterval) {
  sample()
  setInterval(sample, measurementInterval)
}
