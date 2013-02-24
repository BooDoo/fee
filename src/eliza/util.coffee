path    = require 'path'
{ env } = process

exports.requireController = (component) ->
  require path.join env.APP_ROOT, 'components', component, 'controller'

exports.log = (args...) ->
  console.log(args...)