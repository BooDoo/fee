eliza       = require 'eliza'
{ express } = eliza

# use `eliza()` to get the
# instance of the express app
app = eliza()


#################################################################
#                                                               #
# Some configuration is handled by eliza:                       #
#   * static path (i.e. /public)                                #
#   * uses app.router                                           #
#   * uses process.env.PORT or 3000 if process.env.PORT == null #
#                                                               #
#################################################################

app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser("your secret here")
app.use express.session()

app.configure "development", ->
  app.use express.errorHandler()

app.listen(app.get('port'))
