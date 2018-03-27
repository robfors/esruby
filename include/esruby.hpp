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


extern const uint8_t app[];


class ESRuby
{

  public:
  
  static void start();
  static void stop();
  
  private:
  
  static mrb_state* _mrb;
  
};

#endif
