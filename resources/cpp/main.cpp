#include "esruby.hpp"

// we need to load the esruby bindings here, see issue:
//   https://github.com/kripken/emscripten/issues/5537
// although you can observe that the bindings in esruby-bind do work
//   so im not sure what the problem is
// idealy i would like to use a compiler option like EXPORTED_FUNCTIONS, but for classes
EMSCRIPTEN_BINDINGS(esruby)
{
  emscripten::class_<ESRuby>("ESRuby")
    .class_function("start", &ESRuby::start)
    .class_function("stop", &ESRuby::stop)
  ;
}
