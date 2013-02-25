casper.start()
casper.open 'http://localhost:4000/todos'

casper.then ->
  @test.assertHttpStatus 404, 'The --no-route flag was passed for todos'

casper.run ->
  @test.done()
