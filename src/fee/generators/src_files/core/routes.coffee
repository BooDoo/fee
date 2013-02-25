app = do (fee = require('fee'))

{requireController} = fee.Util

app.get '/', (req, res) ->
  res.send 200, 'HELLO WORLD!'
