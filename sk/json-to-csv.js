const stringify = require('csv-stringify')
const fs = require('fs')
const lodash = require('lodash')
const input = require('./slovakia-cities.json')
const header = ["PartitionKey", "RowKey", "Nazev", "NazevAscii", "Okres", "Kraj", "GpsLat", "GpsLon"]

stringify([header, bratislava(), kosice(), ...input.map(convert)], function(err, output){
  fs.writeFileSync('output.csv', output)
})

function convert(row) {
  const cityAscii = lodash.kebabCase(row.city)
  const countyAscii = lodash.kebabCase(row.county)
  return [
    countyAscii,
    cityAscii,
    row.city,
    cityAscii.replace(/-/g, ' '),
    row.county,
    row.region,
    row.latitude,
    row.longitude
  ]
} 

function bratislava() {
  return ['bratislava', 'bratislava', 'Bratislava', 'bratislava', 'Bratislava', 'Bratislavský', 48.151699, 17.109306]
}

function kosice() {
  return ['kosice', 'kosice', 'Košice', 'kosice', 'Košice', 'Košický', 48.717227, 21.249677]
}