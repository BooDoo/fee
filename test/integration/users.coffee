casper.start()
casper.open 'http://localhost:4000/users'

casper.then ->
  @test.assertHttpStatus 200, '/users is available'

casper.run ->
  @test.done()
