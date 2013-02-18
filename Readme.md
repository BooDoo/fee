# Eliza

Wanted to create a very minimal tool for generating application shells custom to my thoughts and preferences on code/file structure for web app projects in node.js. I've been manually organizing and setting up all my apps at the beginning of a project and am tired of all the time I waste on setup.

## Install

`npm install -g git://github.com/benjreinhart/eliza.git`

## Usage

```
Usage: eliza [options] [command]

Commands:

  new <name>             Create a new application <name>
  cmpt <cmpt> [path]     Generate component <cmpt>, optionally at <path>/components/<cmpt>

Options:

  -h, --help      output usage information
  -V, --version   output the version number
  -b, --bare      Only add a controller file for a component
  -R, --no-route  Do not add a route when generating a component
```

## Commands

### new

`eliza new <project>`

`new` will generate a new application `<project>`. If `<project>` is a path (relative or absolute) then it will create the skeleton application at that path and use the basename as name of the application.

`eliza new ~/Desktop/my-project`

will generate:

```
* /Users/ben/Desktop/my-project/
  * components/
  * core/
    * config/
    * frontend/
    * layouts/
    * lib/
    - routes.coffee
  * public/
  - env.sh
  - Makefile
  - package.json
```

### component

`eliza cmpt <cmpt> [path]`

`cmpt` will generate a new component `<cmpt>` in the /components directory in the current working directory, or at `<path>/components/<cmpt>` if a path is supplied, i.e. the command:

`eliza cmpt users ~/Desktop/myproject`

will generate a `users` directory inside of `my-project/components`. The result looks like

```
* /Users/ben/Desktop/my-project/
  * components/
    * users/
      * coffeescripts/
      * styles/
      * templates/
      - controller.coffee
```

Supplying the `--no-route` flag will tell eliza not to add a route to the `core/routes.coffee` file for the component.

Supplying the `--bare` fag will tell eliza not to add any subdirectories under `<cmpt>`, only a controller file.
