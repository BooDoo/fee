program = require 'commander'

program
  .version('0.0.1')
  .option('-c, --component', 'Add new component in /components')
  .parse(process.argv)
