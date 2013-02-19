fs      = require 'fs'
express = require 'express'
{ log } = require './eliza/util'
{ env } = process

getPort = -> env.PORT ? 3000
requireCore = (path) -> require "#{ env.APP_ROOT }/core/#{ path }"

bootApplication = (app) ->
  log "Booting eliza server on port #{ getPort() }"

  setupBaseConfiguration(app)

  requireCore('server')
  requireCore('routes')

  runInitializers(app)

setupBaseConfiguration = (app) ->
  app.set "port", getPort()
  app.use app.router
  app.use express.static "#{ env.APP_ROOT }/public"

runInitializers = (app) ->
  path = "#{ env.APP_ROOT }/core/config/initializers"

  fs.readdir path, (err, files) ->
    throw err if err?

    for file in files
      require "#{path}/#{file}"



################
# EXPORT ELIZA #
################

{ eliza, initialize } = do ->

  # `app` will be used to store our express app
  # throughout the life-cycle of a running server
  #
  # It is defined in here so the only way to access
  # it is through calling `eliza()`.
  #
  app = null

  {

    initialize: ->
      # Shouldn't be called twice, but if
      # so, just return the express instance
      return app if app?

      # Otherwise, create the express
      # instance and boot the eliza application
      app = express()
      bootApplication(app)

      # return the express instance
      app

    # eliza will just proxy this bad mother
    eliza: -> app

  }

module.exports = eliza

eliza.Util       = require "#{ __dirname }/eliza/util"
eliza.express    = express
eliza.initialize = initialize
