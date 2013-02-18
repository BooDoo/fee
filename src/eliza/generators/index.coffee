fs       = require 'fs'
Path     = require 'path'
mkdirp   = require 'mkdirp'
Mustache = require 'mustache'

SRC_PATH = "#{ __dirname }/src_files"
TEMPLATE_PATH = "#{ SRC_PATH }/templates"

class Project
  @create: (path) ->
    (new this(path)).init()

  constructor: (@path) ->
    @name = Path.basename(@path)

  init: ->
    createDirectory @path

    @_createTopLevelDirectories()
    @_createCoreDirectories()
    @_createPackageJSON()
    @_createCoreFiles()
    @_createMakefile()
    @_createEnvSh()

    this

  component: (component, options={}) ->
    componentPath = "#{ @path }/components/#{ component }"

    createDirectory componentPath
    @_addController componentPath, component

    if !options.bare
      createDirectories componentPath, 'templates', 'coffeescripts', 'styles'

    @_addRoute(component) if options.includeRoute

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
    template = fs.readFileSync "#{ TEMPLATE_PATH }/package.json.mustache", 'utf8'

    json = Mustache.render(template, { @name })
    fs.writeFileSync "#{ @path }/package.json", json

  _createCoreFiles: ->
    routes = fs.readFileSync "#{ SRC_PATH }/core/routes.coffee", 'utf8'
    fs.writeFileSync "#{ @path }/core/routes.coffee", routes

  _createMakefile: ->
    contents = fs.readFileSync "#{ SRC_PATH }/Makefile", 'utf8'
    fs.writeFileSync "#{ @path }/Makefile", contents

  _createEnvSh: ->
    contents  = fs.readFileSync "#{ SRC_PATH }/env.sh", 'utf8'
    envShPath = "#{ @path }/env.sh"

    fs.writeFileSync envShPath, contents
    fs.chmodSync envShPath, '744'

  _addController: (componentPath, component) ->
    template = fs.readFileSync "#{ TEMPLATE_PATH }/controller.coffee.mustache", 'utf8'

    controller = Mustache.render template, { component }
    fs.writeFileSync "#{ componentPath }/controller.coffee", controller

  _addRoute: (component) ->
    template = fs.readFileSync "#{ TEMPLATE_PATH }/add_route.coffee.mustache", 'utf8'

    route = Mustache.render template, { component }
    fs.appendFileSync "#{ @path }/core/routes.coffee", route, 'utf8'


  ###########
  # PRIVATE #
  ###########

  createDirectories = (path, directories...) ->
    for directory in directories
      createDirectory "#{ path }/#{ directory }"

  createDirectory = (path) ->
    mkdirp path


module.exports = Project
