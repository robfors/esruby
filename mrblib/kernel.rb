module Kernel

  def exit
    raise ESRuby::ExitSignal
    nil
  end
  
end
