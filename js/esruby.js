class ESRuby
{
  
  static start()
  {
    Module.ESRuby.start();
  }
  
  static stop()
  {
    Module.ESRuby.stop();
  }
  
}

var global = (typeof global === 'object' ? global: window);
global.addEventListener("load", ESRuby.start);
global.addEventListener("unload", ESRuby.stop);
