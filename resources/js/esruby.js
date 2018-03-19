ESRuby = class
{
  constructor()
  {
    if (ESRuby.instance)
      return ESRuby.instance;
    
  }
  
  // Default print level is errors only
  this.print_level = 1;
      if (typeof opts.print_level === "number" && opts.print_level >= 0)
      {
        this.print_level = opts.print_level;
      }
      this.mrb = _mrb_open();
      _esruby_internal_setup(this.mrb);
    };
    
    ESRUBY.prototype.close = function()
    {
      _mrb_close(this.mrb);
    };
    
    ESRUBY.prototype.run = function()
    {
      _esruby_internal_run(this.mrb, this.print_level);
    };
    
    ESRUBY.prototype.set_print_level = function(level)
    {
      if (level >= 0) this.print_level = level;
    };
    

    if (typeof window === 'object')
    {
      window['ESRUBY'] = ESRUBY;
    }
    else
    {
      global['ESRUBY'] = ESRUBY;
    }
  }
) ();
