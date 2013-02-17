fs      = require 'fs'
program = require 'commander'

ROOT    = "#{ __dirname }/.."
Project = require ROOT

cwd = process.cwd()

program.version JSON.parse(fs.readFileSync("#{ ROOT }/package.json", 'utf8')).version


# New project
program
  .command('new <name> [path]')
  .description('Create a new application <name> in cwd or optionally at <path>')
  .action (name, path) ->
    path = "#{ resolvePath(path) }/#{ name }"
    Project.create(path)


# New component
program
  .command('component <component> [path]')
  .description('Generate component <component>, optionally at <path>/components/<component>')
  .action (component, path) ->
    project = new Project resolvePath(path)
    project.component(component)



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
