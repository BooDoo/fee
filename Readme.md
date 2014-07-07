# fee

Wanted to create a very minimal tool for generating application shells custom to my thoughts and preferences on code/file structure for web app projects in node.js. I've been manually organizing and setting up all my apps at the beginning of a project and am tired of all the time I waste on setup.

fee is basically a structural wrapper around express that is _convention over configuration_ based.

## Install

`npm install -g fee`

## Usage

```
Usage: fee [options] [command]

Commands:

  new <name>             Create a new application <name>
  cmpt <cmpt> [path]     Generate component <cmpt>, optionally at <path>/components/<cmpt>
  server                 Start the fee server

Options:

  -h, --help            output usage information
  -V, --version         output the version number
  -r, --include-readme  Include a project README
  -L, --no-latte        Don't include the latte view engine
  -b, --bare            Only add a controller file for a component
  -R, --no-route        Do not add a route when generating a component
```

## Commands

### new

`fee new <name>`

`new` will generate a new application `<name>`. If `<name>` is a path (relative or absolute) then it will create the application at that path and use the basename as name of the application.

`fee new ~/Desktop/my-project`

will generate:

```
* /Users/ben/Desktop/my-project/
  * components/
  * core/
    * config/
      * initializers/
    * frontend/
    * layouts/
    * lib/
    - routes.coffee
    - server.coffee
  * public/
  - env.sh
  - Makefile
  - package.json
```

Supplying the `--no-latte` flag will not include the latte view rendering library.


### cmpt

`fee cmpt <cmpt> [path]`

`cmpt` will generate a new component `<cmpt>` in the /components directory in the current working directory, or at `<path>/components/<cmpt>` if a path is supplied, i.e. the command:

`fee cmpt users ~/Desktop/myproject`

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

Supplying the `--no-route` flag will tell fee not to add a route to the `core/routes.coffee` file for the component.

Supplying the `--bare` flag will tell fee not to add any subdirectories under `<cmpt>`, only a controller file.

### server

`fee server`

Starts the fee (express) server. The one caveat here is that it expects two environment variables to be set: `APP_ROOT` and `PORT`. fee needs `APP_ROOT` to know where to look for files, etc. If `PORT` isn't in the environment, it'll default to 3000.

The Makefile that is generated has a `dev` command which will run the `fee` server command through the env.sh file. That file is where the environment variables should be defined.

## License

(The MIT License)

Copyright (c) 2012 Ben Reinhart <benjreinhart@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
