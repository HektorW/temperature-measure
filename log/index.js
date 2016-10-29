const bunyan = require('bunyan')

module.exports = function createLog(name) {
  return bunyan.createLogger({
    name,
    level: 'debug',
    stream: process.stdout,
    serializers: {
      req: ({ url, method }) => ({ url, method }),
    },
  })
}
