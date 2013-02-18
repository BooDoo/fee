{ env } = process

exports.requireController = (component) ->
  require "#{ env.APP_ROOT }/components/#{ component }"
