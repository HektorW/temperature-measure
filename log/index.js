const bunyan = require('bunyan')

module.exports = function createLog(name) {
  return bunyan.createLogger({
    name,
    stream: process.stdout,
  })
}
