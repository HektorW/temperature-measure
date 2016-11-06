const { appendFile, readFile, stat } = require('mz/fs')
const { createReadStream } = require('fs')
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

// function read(count = 1, start = 0) {
//   return co(function* () {
//     const content = yield readFile(outputFile, 'utf8')
//     const allLines = content.split(/\n/g)
//     const selectedEntries = allLines
//       .filter(line => /\{.+\}/.test(line))
//       .reverse()
//       .slice(start, start + count)
//     return selectedEntries.map(entryStr => JSON.parse(entryStr))
//   })
// }


function* readLarge(count = 1) {
  const stats = yield stat(outputFile)
  const fileSize = stats.size

  const approxItemSize = 200
  const readSize = approxItemSize * count
  const startRead = fileSize - readSize
  const fileContent = yield readPartialFile(outputFile, startRead)

  const entries = fileContent.split(/\n/g)
  const selectedEntries = entries
      .filter(line => /\{.+\}/.test(line))
      .reverse()
      .slice(0, count)

  return selectedEntries.map(entryStr => JSON.parse(entryStr))
}

function readPartialFile(path, start) {
  return new Promise((resolve, reject) => {
    const stream = createReadStream(path, { start })
    let content = ''
    stream.on('data', chunk => content += chunk)
    stream.on('end', () => resolve(content))
    stream.on('error', error => reject(error))
  })
}

module.exports = {
  write,
  // read,
  read: co.wrap(readLarge),
}
