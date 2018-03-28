#include "esruby.hpp"

mrb_state* ESRuby::_mrb = nullptr;

mrb_state* ESRuby::mrb()
{
  if (!_mrb)
  {
    printf("Error: esruby not active\n");
    throw std::runtime_error("Error: esruby not active");
  }
  return _mrb;
}

void ESRuby::start()
{
  if (_mrb)
  {
    printf("Error: esruby already started\n");
    throw std::runtime_error("Error: esruby already started");
  }
  _mrb = mrb_open();
  if (!_mrb)
  {
    printf("error opening new mrb state\n");
    throw std::runtime_error("error opening new mrb state");
  }
  mrb_load_irep(_mrb, app);
  // print error if any
  if (_mrb->exc)
  {
    mrb_p(_mrb, mrb_obj_value(_mrb->exc));
    _mrb->exc = 0;
    throw std::runtime_error("ruby error encountered");
  }
}

void ESRuby::stop()
{
  if (!_mrb)
  {
    printf("Error: esruby not active\n");
    throw std::runtime_error("Error: esruby not active");
  }
  mrb_close(_mrb);
  // print error if any
  if (_mrb->exc)
  {
    mrb_p(_mrb, mrb_obj_value(_mrb->exc));
    _mrb->exc = 0;
    throw std::runtime_error("ruby error encountered");
  }
}

void mrb_esruby_esruby_gem_init(mrb_state* mrb)
{
}


void mrb_esruby_esruby_gem_final(mrb_state* mrb)
{
}
