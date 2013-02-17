mkdirp = require 'mkdirp'

exports.create = (path) ->
  mkdirp path

  createSubDirectories(path)



###########
# PRIVATE #
###########

createSubDirectories = (path) ->
  for directory in ['core', 'components', 'public']
    mkdirp "#{ path }/#{ directory }"