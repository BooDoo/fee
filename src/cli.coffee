ROOT    = "#{ __dirname }/.."
fs      = require 'fs'
program = require 'commander'
Project = require ROOT

cwd = process.cwd()

program.version JSON.parse(fs.readFileSync("#{ ROOT }/package.json", 'utf8')).version


program
  .command('new <name> [path]')
  .description('Create a new application <name> in cwd or at <path> if <path> is supplied')
  .action (name, path) ->
    path = path ? cwd
    path = "#{ cwd }/#{ path }" unless isAbsolute(path)
    path = resolvePathToApp(name, path)

    Project.create path



###########
# PRIVATE #
###########

isAbsolute = (path) ->
  path.match(/^\//)?

resolvePathToApp = (name, path) ->
  path = stripTrailingSlash(path) if hasTrailingSlash(path)

  "#{ path }/#{ name }"

stripTrailingSlash = (path) ->
  path.slice(0, path.length - 1)

hasTrailingSlash = (path) ->
  path.match(/\/$/)?

# Kick off the CLI:
program.parse(process.argv)
