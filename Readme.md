# Eliza

Wanted to create a very minimal framework for node.js custom to my thoughts and preferences on code/file structure for web app projects. I've been manually organizing and setting up all my apps at the beginning of a project and am tired of all the time I waste on setup.

## Usage

```
Usage: eliza [options] [command]

Commands:

  new <name> [path]      Create a new application <name>
  cmpt <cmpt> [path]     Generate component <cmpt>, optionally at <path>/components/<cmpt>

Options:

  -h, --help     output usage information
  -V, --version  output the version number
```

## Commands

### new

`eliza new <project> [path]`

`new` will generate a new application `<project>` in the current working directory, or at `<path>` if a path is supplied, i.e. the command:

`eliza new my-project ~/Desktop`

will generate:

```
* /Users/ben/Desktop/my-project/
  * components/
  * core/
  * public/
  - env.sh
  - Makefile
  - package.json
```

### component

`eliza cmpt <cmpt> [path]`

`cmpt` will generate a new component `<cmpt>` in the current working directory, or at `<path>` if a path is supplied, i.e. the command:

`eliza cmpt users ~/Desktop/myproject`

will generate a `users` directory inside of `my-project/components`. The result looks like

```
* /Users/ben/Desktop/my-project/
  * components/
    * users/
      * coffeescripts/
      * styles/
      * templates/
```