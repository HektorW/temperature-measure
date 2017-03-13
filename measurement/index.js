const { getRawOutput, parseTemperature } = require('./sensor')
const { initialize, write } = require('./db-storage')
const { sensorLocation: location } = require('../config')

async function sample() {
  const rawOutput = await getRawOutput()
  const temperature = parseTemperature(rawOutput)
  write({ rawOutput, temperature, location })
}

module.exports.start = async function start(measurementInterval) {
  await initialize()
  sample()
  setInterval(sample, measurementInterval)
}
