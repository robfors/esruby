module ESRuby
  class Gem
    class Specification
    
      @specifications = []
      
      class << self
        attr_reader :specifications
      end
      
      def self.new(*arguments)
        new_specification = super(*arguments)
        @specifications << new_specification
        new_specification
      end
      
      attr_reader :prepended_js_sources, :appended_js_sources
      
      def initialize(&block)
        @prepended_js_sources = []
        @appended_js_sources = []
        instance_eval(&block)
      end
      
      def add_prepended_js_source(path)
        @prepended_js_sources << path
      end
      
      def add_appended_js_source(path)
        @appended_js_sources << path
      end
      
    end
  end
end
