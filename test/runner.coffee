cp      = require 'child_process'
async   = require 'async'
request = require 'request'

process.env.NODE_ENV = 'test'

{FEE, TEST_APPLICATION} = process.env

app = null

applicationENV = ->
  process.env.PORT = 4000
  process.env.APP_ROOT = TEST_APPLICATION
  process.env

bootServer = (done) ->
  console.log()
  app = cp.spawn FEE, [ 'server' ], { env: applicationENV() }

  app.stdout.pipe process.stdout
  app.stderr.pipe process.stderr

  app.stdout.on 'data', (data) ->
    if data.toString().match 'Booting fee server on port 4000'
      app.stdout.removeAllListeners 'data'
      done()

waitForServer = (done) ->
  setTimeout (-> done()), 200

casperjs = (done) ->
  casper = cp.spawn 'casperjs', ['test', 'test/integration']
  casper.stdout.pipe process.stdout
  casper.stderr.pipe process.stderr
  casper.on 'exit', done

killTestServer = ->
  app.on 'exit', ->
    app.stdout.removeAllListeners()
    app.stderr.removeAllListeners()
  app.kill()

finish = (err) ->
  if err?
    console.log 'Error shutting down: ', err

  killTestServer()

async.waterfall [
  bootServer
  waitForServer
  casperjs
], finish
