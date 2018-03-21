# ESRuby
This project brings *mruby* to the browser. It uses *emscripten*
(https://github.com/kripken/emscripten) to compile the mruby source code into
JavaScript (ECMAScript) and runs in the browser. It is heavily based off *webruby* (https://github.com/xxuejie/webruby) but has been adjusted to work with the updates to *emscripten* and *mruby*.

# Install
*ESRuby* depends on [emsdk](http://kripken.github.io/emscripten-site/index.html) to provide a tool chain consisting of *emscripten* and *LLVM*. Although the tool chain is available from `apt-get` we will need to build emscripten from source using my branch as I have introduced some new features that have not made it into the release yet.

* we will start with a clean instance of Ubuntu 16.04 with ruby MRI installed
* `cd` to a directory where you want *emsdk* downloaded
* `git clone https://github.com/juj/emsdk.git`
* `cd emsdk`
* `git reset --hard 313d5ef` # optional, but it may help if you find that `master` is too new for my fork
* as per the [documentation](http://kripken.github.io/emscripten-site/docs/building_from_source/building_emscripten_from_source_using_the_sdk.html) we will first install from the main repositories then replace *emscripten* with my fork:
* `./emsdk install sdk-incoming-64bit`
* `./emsdk activate sdk-incoming-64bit`
* `cd emscripten/incoming`
* `git remote add fork https://github.com/robfors/emscripten.git`
* `git fetch fork esruby`
* `git checkout -b esruby fork/esruby`
* `cd ../..`
* `source ./emsdk_env.sh` # calling this will add necessary paths to bash
* optional: make the last command persistent by adding\
`[ -f /path_to_emsdk/emsdk_env.sh ] && source /path_to_emsdk/emsdk_env.sh > /dev/null 2>&1`\
to your `.bashrc` and `.profile`
* verify emsdk is working with `emcc -v`
* install this gem with `gem install esruby`

# Try
* create a new esruby project with `esruby new project`
* `cd project`
* build the project with `esruby build config.rb`
* you will now have `www/app.js` and `www/index.html`
* a simple way to serve these files would be `ruby -run -e httpd www -p 4444`
* the app with be available at http://localhost:4444
# License

This project is distributed under the MIT License. See LICENSE for further details.
