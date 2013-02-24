var path  = require('path')
  , eliza = path.join(__dirname, 'src');

require('coffee-script');
module.exports = require(eliza);