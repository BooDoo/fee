casper.start()
casper.open 'http://localhost:4000'

casper.then ->
  @test.assertHttpStatus 200, 'Root url is available'

casper.run ->
  @test.done()
