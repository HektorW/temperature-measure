const output = `
72 01 4b 46 7f ff 0e 10 57 : crc=57 YES

72 01 4b 46 7f ff 0e 10 57 t={TEMPERATURE}
`

const randRangeInt = (min, max) => min + Math.floor(Math.random() * (max - min))

function getRawOutput() {
  const mockTemperature = randRangeInt(19000, 24000)
  return Promise.resolve(output.replace('{TEMPERATURE}', mockTemperature))
}

module.exports = { getRawOutput }
