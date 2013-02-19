{ env } = process

exports.requireController = (component) ->
  require "#{ env.APP_ROOT }/components/#{ component }/controller"

exports.log = (args...) ->
  console.log(args...)