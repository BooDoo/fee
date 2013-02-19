express = require 'express'

# This will be used to store our express app
# throughout the life-cycle of a running server
app = null

eliza = ->
  app = app ? express()


srcRequire = (path) -> require "#{ __dirname }/eliza/#{ path }"

eliza.Util        = srcRequire 'util'
eliza.Application = srcRequire 'generators'

module.exports = eliza
