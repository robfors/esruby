#include "esruby.hpp"

ESRuby::ESRuby()
{
  _mrb = mrb_open();
  if (!_mrb)
    throw std::runtime_error("error opening new mrb state");
  _print_level = 1;
}

ESRuby::~ESRuby()
{
  mrb_close(_mrb);
}

int ESRuby::get_print_level()
{
  return _print_level;
}

void ESRuby::run()
{
  mrb_value result = mrb_load_irep(_mrb, app);
  
  // print levels:
  switch(_print_level)
  {
    case 0: // do not print anything
      break;
    case 1: // print errors only
      if (_mrb->exc)
      {
        mrb_p(_mrb, mrb_obj_value(_mrb->exc));
        _mrb->exc = 0;
      }
      break;
    case 2: // print errors and results
      if (_mrb->exc)
      {
        mrb_p(_mrb, mrb_obj_value(_mrb->exc));
        _mrb->exc = 0;
      }
      mrb_p(_mrb, result);
      break;
  }
}

void ESRuby::set_print_level(int new_print_level)
{
  if (new_print_level >= 0 && new_print_level <= 2)
    _print_level = new_print_level;
  else
    throw std::runtime_error("print level not valid");
}

EMSCRIPTEN_BINDINGS(esruby)
{
  emscripten::class_<ESRuby>("Webruby")
    .constructor<>()
    .function("get_print_level", &ESRuby::get_print_level)
    .function("run", &ESRuby::run)
    .function("set_print_level", &ESRuby::set_print_level)
  ;
}
