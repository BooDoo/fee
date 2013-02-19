fs      = require 'fs'
program = require 'commander'

ROOT = "#{ __dirname }/.."

Eliza       = require ROOT
Application = require "#{ ROOT }/src/eliza/generators"

cwd = process.cwd()

program.version JSON.parse(fs.readFileSync("#{ ROOT }/package.json", 'utf8')).version


# New application
program
  .command('new <name>')
  .description('Create a new application <name>')
  .action (name) ->
    Application.create(resolvePath(name))

program
  .option('-b, --bare', 'Only add a controller file for a component')
  .option('-R, --no-route', 'Do not add a route when generating a component')

# New component
program
  .command('cmpt <cmpt> [path]')
  .description('Generate component <cmpt>, optionally at <path>/components/<cmpt>')
  .action (component, path) ->
    app = new Application resolvePath(path)
    app.component(component, includeRoute: program.route, bare: program.bare)

# Start the server
program
  .command('server')
  .description('Start the eliza server')
  .action ->
    if not process.env.APP_ROOT?
      throw "Must define an environment variable `APP_ROOT` with the absolute path to your eliza application"

    Eliza()



###########
# PRIVATE #
###########

isAbsolute = (path) ->
  path.match(/^\//)?

resolvePath = (path = cwd) ->
  return path if isAbsolute(path)

  "#{ cwd }/#{ path }"

# Kick off the CLI:
program.parse(process.argv)
