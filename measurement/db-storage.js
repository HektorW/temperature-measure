const { join } = require('path')
const { Database } = require('sqlite3')
const log = require('../log')(__filename)

const dbFile = join(__dirname, 'measurements.sqlite3')
const tableName = 'measurements'
const tableColumns = '(raw TEXT, location TEXT, temperature REAL, datetime INTEGER)'
let db

function initialize() {
  return new Promise((resolve, reject) => {
    db = new Database(dbFile, onOpen)

    function onOpen(error) {
      if (error) {
        log.error({ error }, 'Failed to open database')
        return reject(error)
      }

      db.run(`CREATE TABLE IF NOT EXISTS ${tableName} ${tableColumns}`, onCreated)
    }

    function onCreated(error) {
      if (error) {
        log.error({ error }, 'Failed to create table')
        return reject(error)
      }

      resolve()
    }
  })

}

function write(measurement) {
  return new Promise((resolve, reject) => {
    const { raw, location, temperature } = measurement
    const datetime = measurement.datetime !== undefined
      ? measurement.datetime
      : Date.now()

    db.run(
      `INSERT INTO ${tableName} (raw, location, temperature, datetime) VALUES (?, ?, ?, ?)`,
      [raw, location, temperature, datetime],
      callback
    )

    function callback(error) {
      if (error) {
        log.error({ error }, 'Failed to write measurement')
        return reject(error)
      }

      resolve()
    }
  })
}

function read(count = 1) {
  return new Promise((resolve, reject) => {
    db.all(
      `SELECT * FROM ${tableName} ORDER BY datetime DESC LIMIT ${count}`,
      callback
    )

    function callback(error, rows) {
      if (error) {
        log.error({ error }, 'Failed to read')
        return reject(error)
      }

      resolve(rows)
    }
  })
}

module.exports = {
  initialize,
  write,
  read,
}
