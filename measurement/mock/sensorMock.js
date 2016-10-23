const { getTemperature, parseTemperature } = require('../sensor')

const output = `
72 01 4b 46 7f ff 0e 10 57 : crc=57 YES

72 01 4b 46 7f ff 0e 10 57 t=23125
`

function getRawOutput() {
  return Promise.resolve(output)
}

module.exports = getTemperature
module.exports.getRawOutput = getRawOutput
module.exports.parseTemperature = parseTemperature
