fs       = require 'fs'
Path     = require 'path'
mkdirp   = require 'mkdirp'
Mustache = require 'mustache'

SRC_PATH = "#{ __dirname }/src_files"

class Project
  @create: (path) ->
    (new this(path)).init()

  constructor: (@path) ->
    @name = Path.basename(@path)

  init: ->
    mkdirp @path

    @_createTopLevelDirectories()
    @_createCoreDirectories()
    @_createPackageJSON()
    @_createMakefile()
    @_createEnvSh()

    this

  component: (component) ->
    mkdirp(component = "#{ @path }/components/#{ component }")
    mkdirp "#{ component }/templates"
    mkdirp "#{ component }/coffeescripts"
    mkdirp "#{ component }/styles"

    this

  #############
  # PROTECTED #
  #############

  _createTopLevelDirectories: ->
    createDirectories @path, 'core', 'components', 'public'

  _createCoreDirectories: ->
    directories = ['config', 'frontend', 'layouts', 'lib']
    createDirectories "#{ @path }/core", directories...

  _createPackageJSON: ->
    template = fs.readFileSync("#{ SRC_PATH }/package.json.mustache", 'utf8')
    json = Mustache.render(template, { @name })
    fs.writeFileSync "#{ @path }/package.json", json

  _createMakefile: ->
    contents = fs.readFileSync "#{ SRC_PATH }/Makefile", 'utf8'
    fs.writeFileSync "#{ @path }/Makefile", contents

  _createEnvSh: ->
    contents = fs.readFileSync "#{ SRC_PATH }/env.sh", 'utf8'
    fs.writeFileSync "#{ @path }/env.sh", contents


  ###########
  # PRIVATE #
  ###########

  createDirectories = (path, directories...) ->
    for directory in directories
      mkdirp "#{ path }/#{ directory }"


module.exports = Project
