fs       = require 'fs'
Path     = require 'path'
mkdirp   = require 'mkdirp'
{ log }  = require '../util'
Mustache = require 'mustache'

SRC_PATH = "#{ __dirname }/src_files"
TEMPLATE_PATH = "#{ SRC_PATH }/templates"

class Application
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

    log "New eliza application was created at #{ @path }"

    this

  component: (component, options={}) ->
    componentPath = "#{ @path }/components/#{ component }"

    createDirectory componentPath
    @_addController componentPath, component

    if !options.bare
      createDirectories componentPath, 'templates', 'coffeescripts', 'styles'

    @_addRoute(component) if options.includeRoute

    log "Created component #{ component }"

    this

  #############
  # PROTECTED #
  #############

  _createTopLevelDirectories: ->
    createDirectories @path, 'core', 'components', 'public', 'test'

  _createCoreDirectories: ->
    directories = ['config', 'config/initializers', 'frontend', 'layouts', 'lib']
    createDirectories "#{ @path }/core", directories...

  _createPackageJSON: ->
    template = readFile "#{ TEMPLATE_PATH }/package.json.mustache"

    json = Mustache.render(template, { @name })
    writeFile "#{ @path }/package.json", json

  _createCoreFiles: ->
    routes = readFile "#{ SRC_PATH }/core/routes.coffee"
    server = readFile "#{ SRC_PATH }/core/server.coffee"

    writeFile "#{ @path }/core/routes.coffee", routes
    writeFile "#{ @path }/core/server.coffee", server

  _createMakefile: ->
    contents = readFile "#{ SRC_PATH }/Makefile"
    writeFile "#{ @path }/Makefile", contents

  _createEnvSh: ->
    contents  = readFile "#{ SRC_PATH }/env.sh"
    envShPath = "#{ @path }/env.sh"

    writeFile envShPath, contents
    fs.chmodSync envShPath, '744'

  _addController: (componentPath, component) ->
    template = readFile "#{ TEMPLATE_PATH }/controller.coffee.mustache"

    controller = Mustache.render template, { component }
    writeFile "#{ componentPath }/controller.coffee", controller

  _addRoute: (component) ->
    template = readFile "#{ TEMPLATE_PATH }/add_route.coffee.mustache"

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

  readFile = (path) ->
    fs.readFileSync path, 'utf8'

  writeFile = (args...) ->
    fs.writeFileSync args...


module.exports = Application
