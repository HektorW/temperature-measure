const { env } = process
module.exports = {
  measurementInterval: env.MEASUREMENT_INTERVAL || 1000 * 60 * 10,
  mockSensor: env.MOCK_SENSOR === 'true' ? true : false,
  port: env.PORT || 1080,
  sensorLocation: env.SENSOR_LOCATION || 'unknown',
}
