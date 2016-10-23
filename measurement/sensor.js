const { readFile } = require('mz/fs')
const { join } = require('path')
const co = require('co')
const { mockSensor } = require('../config')

const dir = '/sys/bus/w1/devices'
const sensorId = '10-00080322f10e'
const fileName = 'w1_slave'
const readPath = join(dir, sensorId, fileName)

function parseTemperature(rawOutput = '') {
  const regex = /t=(\d{5})/
  const [ , temperature] = rawOutput.match(regex) || []
  if (!temperature) {
    return NaN
  }

  const withDot = temperature.substr(0, 2) + '.' + temperature.substr(2)
  return parseFloat(withDot)
}

function getRawOutput() {
  return co(function* () {
    return yield readFile(readPath, 'utf8')
  })
}

function getTemperature() {
  return getRawOutput().then(rawOutput => parseTemperature(rawOutput))
}

if (mockSensor) {
  getRawOutput = require('./mock/sensorMock').getRawOutput // eslint-disable-line no-func-assign
}

module.exports = getTemperature
module.exports.getTemperature = getTemperature
module.exports.getRawOutput = getRawOutput
module.exports.parseTemperature = parseTemperature
