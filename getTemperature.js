const { readFile } = require('fs')
const { join } = require('path')

const dir = '/sys/bus/w1/devices'
const sensorId = '10-00080322f10e'
const fileName = 'w1_slave'

function parseRawTemperature(rawTemperature = '') {
  const regex = /t=(\d{5})/
  const [_, temperature] = rawTemperature.match(regex) || []
  if (!temperature) return NaN
  const withDot = temperature.substr(0, 2) + '.' + temperature.substr(2)
  return parseFloat(withDot)
}

module.exports = function getTemperature() {
  return new Promise((resolve, reject) => {
    readFile(join(dir, sensorId, fileName), 'utf8', (err, content) => {
      err ? reject(err) : resolve(parseRawTemperature(content))
    })
  })
}

