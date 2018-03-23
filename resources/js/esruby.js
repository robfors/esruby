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

window.addEventListener("load", ESRuby.start);
window.addEventListener("unload", ESRuby.stop);
