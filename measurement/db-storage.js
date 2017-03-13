const { join } = require('path')
const Sqlite = require('sqlite')
const log = require('../log')(__filename)

const dbFile = join(__dirname, 'measurements.sqlite3')
const tableName = 'measurements'
const tableColumns = '(raw TEXT, location TEXT, temperature REAL, datetime INTEGER)'
let db

exports.initialize = async function initialize() {
  db = await Sqlite.open(dbFile, { Promise })
  await db.run(`CREATE TABLE IF NOT EXISTS ${tableName} ${tableColumns}`)
}

exports.write = async function write(measurement) {
  const { raw, location, temperature } = measurement
  const datetime = measurement.datetime !== undefined
    ? measurement.datetime
    : Date.now()

  await db.run(
    `INSERT INTO ${tableName} (raw, location, temperature, datetime) VALUES (?, ?, ?, ?)`,
    [raw, location, temperature, datetime]
  )
}

exports.read = async function read(count = 1) {
  return await db.all(`SELECT * FROM ${tableName} ORDER BY datetime DESC LIMIT ${count}`)
}
