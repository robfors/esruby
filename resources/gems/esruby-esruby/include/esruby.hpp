#ifndef _ESRUBY_HPP_
#define _ESRUBY_HPP_

#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <stdio.h>
#include <math.h>
#include <mruby.h>
#include <mruby/array.h>
#include <mruby/class.h>
#include <mruby/data.h>
#include <mruby/proc.h>
#include <mruby/string.h>
#include <mruby/value.h>
#include <mruby/variable.h>
#include <mruby.h>
#include <mruby/irep.h>


#include <mruby/dump.h>


extern const uint8_t main_irep[];


class ESRuby
{

  public:
  
  static mrbc_context* context();
  static bool is_alive();
  static mrb_state* mrb();
  static void shutdown();
  static void start();
  
  private:
  
  static mrbc_context* _context;
  static mrb_state* _mrb;
  static bool _is_started;
  
};

extern "C"
void mrb_esruby_esruby_gem_init(mrb_state* mrb);

extern "C"
void mrb_esruby_esruby_gem_final(mrb_state* mrb);

#endif
