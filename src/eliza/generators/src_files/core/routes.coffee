{ Router, Util } = require 'eliza'

{ requireController } = Util

Router.get '/', (req, res) ->
  res.send 200, 'HELLO WORLD!'
