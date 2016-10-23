const { appendFile, readFile } = require('mz/fs')
const { join } = require('path')
const co = require('co')
const log = require('../log')('measurement/storage')

const outputFile = join(__dirname, 'temperature.log')

function write(output) {
  const meta = {
    time: (new Date()).toISOString(),
  }
  const entry = Object.assign(meta, output)
  const entryStr = JSON.stringify(entry) + '\n'
  appendFile(outputFile, entryStr, 'utf8').catch(
    error => log.error(error, 'write:appendFile')
  )
}

function read(count = 1, start = 0) {
  return co(function* () {
    const content = yield readFile(outputFile, 'utf8')
    const allEntries = content.split(/}\\n/g)
    const entries = allEntries.slice(start, start + count)
    return entries.map(entryStr => JSON.parse(entryStr))
  })
}

module.exports = {
  write,
  read,
}
