fs       = require 'fs'
Path     = require 'path'
mkdirp   = require 'mkdirp'
Mustache = require 'mustache'

SRC_PATH = "#{ __dirname }/src_files"


exports.create = (path) ->
  (new Project(path)).create()


class Project
  constructor: (@path) ->
    @name = Path.basename(@path)

  create: ->
    mkdirp @path

    @createTopLevelDirectories()
    @createCoreDirectories()
    @createPackageJSON()
    @createMakefile()
    @createEnvSh()

  createTopLevelDirectories: ->
    createDirectories @path, 'core', 'components', 'public'

  createCoreDirectories: ->
    directories = ['config', 'frontend', 'layouts', 'lib']
    createDirectories "#{ @path }/core", directories...

  createPackageJSON: ->
    template = fs.readFileSync("#{ SRC_PATH }/package.json.mustache", 'utf8')
    json = Mustache.render(template, { @name })
    fs.writeFileSync "#{ @path }/package.json", json

  createMakefile: ->
    contents = fs.readFileSync "#{ SRC_PATH }/Makefile", 'utf8'
    fs.writeFileSync "#{ @path }/Makefile", contents

  createEnvSh: ->
    contents = fs.readFileSync "#{ SRC_PATH }/env.sh", 'utf8'
    fs.writeFileSync "#{ @path }/env.sh", contents


  ###########
  # PRIVATE #
  ###########

  createDirectories = (path, directories...) ->
    for directory in directories
      mkdirp "#{ path }/#{ directory }"
