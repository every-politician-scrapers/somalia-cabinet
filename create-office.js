// wd create-entity create-office.js "Minister for X"

const fs = require('fs');
let rawmeta = fs.readFileSync('meta.json');
let meta = JSON.parse(rawmeta);

module.exports = (label) => {
  return {
    type: 'item',
    labels: {
      en: label,
    },
    descriptions: {
      en: 'cabinet position in Somalia',
    },
    claims: {
      P31:   { value: 'Q294414' }, // instance of: public office
      P279:  { value: 'Q83307'  }, // subclas of: minister
      P17:   { value: 'Q1045'   }, // country: Somalia
      P1001: { value: 'Q1045'   }, // jurisdiction: Somalia
      P361: {                      // part of: Cabinet of Somalia
        value: 'Q7559139',
        references: {
          P854: meta.source.url,
        },
      }
    }
  }
}
