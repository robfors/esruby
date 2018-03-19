# ESRuby
This project brings *mruby* to the browser. It uses *emscripten*
(https://github.com/kripken/emscripten) to compile the mruby source code into
JavaScript (ECMAScript) and runs in the browser. It is heavily based off *webruby* (https://github.com/xxuejie/webruby) but has been adjusted to work with the updates to *emscripten* and *mruby*.

# How to Install

*ESRuby* depends on [emsdk](http://kripken.github.io/emscripten-site/docs/getting_started/downloads.html) to provide emscripten and LLVM infrustructure. To try *ESRuby*, follow these steps:

TODO: instructions will not work yet

1. Install emsdk following instructions at [here](http://kripken.github.io/emscripten-site/docs/getting_started/downloads.html)
2. Install latest incoming version of emscripten sdk(right now webruby still depends on code from incoming branch of emscripten, once this goes into a release version, we will lock the version for better stability)
3. Activate latest incoming version
4. Webruby should be able to pick up the correct version of emscripten from emsdk. If not, feel free to create an issue :)
5. Install gem `gem install esruby`
6. Create new project with `esruby new <name>`
7. Build project with `esruby build [config.rb]`

# License

This project is distributed under the MIT License. See LICENSE for further details.
