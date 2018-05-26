module ESRuby

  def self.run_app(&app_block)
    Thread.new do
      yield
    end
  end
  
end
