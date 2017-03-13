const { join } = require('path')
const { createLogger } = require('bunyan')


const defaultOptions = {
  level: 'debug',
  stream: process.stdout,
  serializers: {
    req: ({ url, method }) => ({ url, method }),
  },
}


function parseName(name) {
  // Assume this file is in the folder "$PROJECTROOT/log"
  const projectRoot = join(__dirname, '../')
  if (name.includes(projectRoot)) {
    name = name
      .replace(projectRoot, '')
      .replace('/index.js', '') // Only display folder name for index.js files
      .replace('.js', '')
  }
  return name
}


module.exports = function createApplicationLogger(name) {
  name = parseName(name)
  return createLogger(
    Object.assign(
      {},
      defaultOptions,
      { name, level: 'debug' }
    )
  )
}
