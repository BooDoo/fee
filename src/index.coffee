fs      = require 'fs'
{log}   = require './fee/util'
{env}   = process
express = require 'express'

getPort = -> env.PORT ? 3000
requireCore = (path) -> require "#{ env.APP_ROOT }/core/#{ path }"

bootApplication = (app) ->
  log "Booting fee server on port #{ getPort() }"

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
# EXPORT fee #
################

{ fee, initialize } = do ->

  # `app` will be used to store our express app
  # throughout the life-cycle of a running server
  #
  # It is defined in here so the only way to access
  # it is through calling `fee()`.
  #
  app = null

  {

    initialize: ->
      # Shouldn't be called twice, but if
      # so, just return the express instance
      return app if app?

      # Otherwise, create the express
      # instance and boot the fee application
      app = express()
      bootApplication(app)

      # return the express instance
      app

    # fee will just proxy this bad mother
    fee: -> app

  }

module.exports = fee

fee.Util       = require "#{ __dirname }/fee/util"
fee.express    = express
fee.initialize = initialize
