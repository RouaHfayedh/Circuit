const request = require('request');
var fs=require('fs');
async function Nearst_Station(lat,lan,i){
  return new Promise( (resolve, reject) => {
request(
  {
    url: 'https://api.foursquare.com/v2/venues/explore',
    method: 'GET',
    qs: {
      client_id: '0DQKZVG2DQMTQ521Z0VJMBTPVY0RPT04APGTVSFCKVLIKSB3',
      client_secret: 'TXLWQLSU0GJIIPW45DKINKNVA0TOQSLUOPKDJPW5XWPRNPP0',
      ll: ''+lat+','+lan+'',
      query: 'station',
      v: '20180323',
      limit: 2,
    },
  },
  function(err, res, body) {
    if (err) {
      console.error(err);
    } else {
      var file='loop'+i+'.json';
      fs.readFile(body, 'utf8', function (err, data) {
      fs.writeFile(file, body,function(err, result) {
        if(err) console.log('error', err);
        resolve (file);
      });
    });
  }
}
);
});
}

module.exports.Nearst_Station=Nearst_Station;