app = (eliza = require 'eliza')()

{ requireController } = eliza.Util

app.get '/', (req, res) ->
  res.send 200, 'HELLO WORLD!'
