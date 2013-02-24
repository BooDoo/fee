fs      = require 'fs'
Path    = require 'path'
ROOT    = Path.join __dirname, '..', '..'
program = require 'commander'

cwd   = process.cwd()
eliza = require ROOT

generator = Path.join ROOT, 'src', 'eliza', 'generators', 'application'

packageJSON = Path.join ROOT, 'package.json'
program.version JSON.parse(fs.readFileSync packageJSON, 'utf8').version

# Options
program
  .option('-r, --include-readme', 'Include a project README')
  .option('-L, --no-latte', "Don't include the latte view engine")
  .option('-b, --bare', 'Only add a controller file for a component')
  .option('-R, --no-route', 'Do not add a route when generating a component')

# New application
program
  .command('new <name>')
  .description('Create a new application <name>')
  .action (name) ->
    Application = require generator
    new Application(resolvePath(name), formatOptions()).create()

# New component
program
  .command('cmpt <cmpt> [path]')
  .description('Generate component <cmpt>, optionally at <path>/components/<cmpt>')
  .action (component, path) ->
    Application = require generator
    app = new Application resolvePath(path), formatOptions()
    app.component(component)

# Start the server
program
  .command('server')
  .description('Start the eliza server')
  .action ->
    if not process.env.APP_ROOT?
      throw "Must define an environment variable `APP_ROOT` with the absolute path to your eliza application"

    eliza.initialize()



###########
# PRIVATE #
###########

formatOptions = ->
  bare: program.bare
  includeRoute: program.route
  includeLatte: program.latte
  includeReadme: program.includeReadme

isAbsolute = (path) ->
  path.match(/^\//)?

resolvePath = (path = cwd) ->
  return path if isAbsolute(path)

  Path.join cwd, path

# Kick off the CLI:
program.parse(process.argv)
