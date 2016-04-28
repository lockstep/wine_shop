var _ = require('lodash');
var request = require('superagent');
var fs = require('fs');
var cheerio = require('cheerio');
var csvStringify = require('csv-stringify');
var async = require('async');

var urls = [
  {
    wineType: 'Cabernet Sauvignon',
    url: 'http://www.getwineonline.com/category_Red-Cabernet'
  },
  {
    wineType: 'Pinot Noir',
    url: 'http://www.getwineonline.com/category_Type-Pinot-Noir'
  },
  {
    wineType: 'Merlot',
    url: 'http://www.getwineonline.com/category_Type-Merlot'
  },
  {
    wineType: 'Chardonnay',
    url: 'http://www.getwineonline.com/category_White-Chardonnay'
  },
  {
    wineType: 'White Sauvignon',
    url: 'http://www.getwineonline.com/category_White-Sauvignon'
  },
  {
    wineType: 'Riesling',
    url: 'http://www.getwineonline.com/category_White-Riesling'
  }
];

var headers = [ 
  'Sku', 'Name', 'Details',
  'Wine Type', 'Vintage', 'Size',
  'Price', 'Sale price', 'Image'
];

// Main program
(()=> {
  var csv = [ headers ];
  var requests = [];
  urls.forEach((item) => {
    requests.push(requestWrapper(item.url, item.wineType));
  });

  async.parallel(requests,
    (err, results) => {
      csv = csv.concat(_.flatten(results));
      genCsv(csv);
    });
})();

function requestWrapper(url, wineType) {
  return (cb) => {
    request.get(url)
    .end((err, res) => {
      $ = cheerio.load(res.request.res.text);
      var table = $('form[name=frmsearch] table').get(4);
      var product = processProducts($, wineType, $(table).children());
      cb(null, product);
    });
  };
}

function genCsv(dataArray) {
  csvStringify(dataArray, (err, output) => {
    console.log(output);
  });
}

function processProducts($, wineType, data) {
  var results = [];
  $(data).each((i, elem) => {
    var name = $(elem).find('a.producttitle').text();
    var vintage = $(elem).find('span.vintage').text();
    var size = $(elem).find('span.bottlesize').text();

    var imgUrl = $(elem).find('img').attr('src');
    imgUrl = getImageUrl(imgUrl)

    var regularPrice = $(elem).find('span.RegularPrice').text();
    regularPrice = getPrice(regularPrice); 
    var salePrice = $(elem).find('span.SalePrice').text();
    salePrice = getPrice(salePrice); 

    var detailsTxt = $(elem).find('a.producttitle').parent().text();
    var sku = getSku(detailsTxt);
    var details = getDetails(detailsTxt);

    results.push([sku, name, details, wineType, vintage, size, regularPrice, salePrice, imgUrl]);
  });
  return results;
}

function getSku(text) {
  var pattern = /Sku:(.+)/g;
  var results = pattern.exec(text)
  return results ? results[1].trim() : '';
}

function getPrice(text) {
  var pattern = /\$(.+)/g;
  var results = pattern.exec(text)
  return results ? results[1] : '';
}

function getDetails(text) {
  var pattern = /\W(.+)(click for more details)/g;
  var results = pattern.exec(text)
  return results ? results[1].trim() : '';
}

function getImageUrl(url) {
  if (_.startsWith(url, '//')) return `http:${url}`;
  if (_.startsWith(url, '/')){
    url = url.replace(/^\//, '');
  }
  var domain = 'http://www.getwineonline.com/';
  return `${domain}/${url}`;
}
