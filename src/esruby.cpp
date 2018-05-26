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

void ESRuby::shutdown()
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
    mrb_print_error(_mrb);
    _mrb = nullptr;
    throw std::runtime_error("ruby error encountered on interpreter shutdown");
  }
  _mrb = nullptr;
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
  
  mrb_irep* app_mrb_irep = mrb_read_irep(_mrb, main_irep);
  struct RProc* app_proc = mrb_proc_new(_mrb, app_mrb_irep);
  mrb_value app_proc_mrb_value = mrb_obj_value(app_proc);
  RClass* esruby_module = mrb_module_get(_mrb, "ESRuby");
  mrb_value esruby_module_mrb_value = mrb_obj_value(esruby_module);
  mrb_funcall_with_block(_mrb, esruby_module_mrb_value, mrb_intern_lit(_mrb, "run_app"), 0, NULL, app_proc_mrb_value);
  //mrb_funcall(_mrb, esruby_module_mrb_value, "run_app", 1, app_proc_mrb_value);
  mrb_irep_decref(_mrb, app_mrb_irep); // call again to free ?
  
  if (_mrb->exc)
  {
    mrb_print_error(_mrb);
    // clear exception and shutdown interpreter
    _mrb->exc = NULL;
    shutdown();
    throw std::runtime_error("ruby error encountered");
  }
}

void mrb_esruby_esruby_gem_init(mrb_state* mrb)
{
}


void mrb_esruby_esruby_gem_final(mrb_state* mrb)
{
}
