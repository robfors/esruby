#include "esruby.hpp"

mrbc_context* ESRuby::_context = nullptr;
mrb_state* ESRuby::_mrb = nullptr;
bool ESRuby::_is_started = false;

mrbc_context* ESRuby::context()
{
  if (!is_alive())
  {
    printf("Error: esruby not alive\n");
    throw std::runtime_error("Error: esruby not alive");
  }
  return _context;
}

//void ESRuby::initialize_gem(mrb_state* mrb)
//{
//  esruby_module = mrb_define_module(mrb, "ESRuby");
//  exit_signal_class = mrb_define_class_under(mrb, esruby_module, "ExitSignal", mrb_class_get(mrb, "Interrupt"));
//}

bool ESRuby::is_alive()
{
  return _mrb != nullptr;
}

mrb_state* ESRuby::mrb()
{
  if (!is_alive())
  {
    printf("Error: esruby not alive\n");
    throw std::runtime_error("Error: esruby not alive");
  }
  return _mrb;
}

void ESRuby::start()
{
  if (_is_started)
  {
    printf("Error: esruby already started once\n");
    throw std::runtime_error("Error: esruby already started once");
  }
  _is_started = true;
  _mrb = mrb_open();
  if (!_mrb)
  {
    printf("error opening new mrb state\n");
    throw std::runtime_error("error opening new mrb state");
  }
  _context = mrbc_context_new(_mrb);
  mrb_load_irep_cxt(_mrb, app, _context);
  if (_mrb->exc)
  {
    RClass* esruby_module = mrb_module_get(_mrb, "ESRuby");
    RClass* exit_signal_class = mrb_class_get_under(_mrb, esruby_module, "ExitSignal");
    if (mrb_obj_is_kind_of(_mrb, mrb_obj_value(_mrb->exc), exit_signal_class))
    {
      // Kernel#exit called
      // this is a clean exit so ignore the exception
      _mrb->exc = NULL;
    }
    else
    {
      // print error
      mrb_p(_mrb, mrb_obj_value(_mrb->exc));
      // should finalizers be called on an exception?
      // i will assume not
      _mrb = nullptr;
      throw std::runtime_error("ruby error encountered");
    }
  }
}

void ESRuby::stop()
{
  if (!is_alive())
  {
    printf("Error: esruby not alive\n");
    throw std::runtime_error("Error: esruby not alive");
  }
  mrb_close(_mrb);
  // print error if any
  if (_mrb->exc)
  {
    mrb_p(_mrb, mrb_obj_value(_mrb->exc));
    _mrb = nullptr;
    throw std::runtime_error("ruby error encountered");
  }
  _mrb = nullptr;
}

void mrb_esruby_esruby_gem_init(mrb_state* mrb)
{
}


void mrb_esruby_esruby_gem_final(mrb_state* mrb)
{
}
