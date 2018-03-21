module ESRuby
  class Build
    class Configuration
    
      attr_reader :ruby_sources, :prepended_js_sources, :appended_js_sources,
        :build_directory, :build_mode, :gems, :mruby_directory,
        :output
      
      def initialize
        @root_directory = nil
        @mruby_directory = "#{ESRuby.gem_directory}/resources/mruby"
        @output = 'output.js'
        @ruby_sources = []
        @prepended_js_sources = []
        @appended_js_sources = []
        @gems = []
      end
      
      def root_directory
        raise "'root_directory' not set" unless @root_directory
        @root_directory
      end
      
      def root_directory=(new_root_directory)
        root_directory = File.expand_path(new_root_directory)
        raise "'root_directory' not found" unless File.directory?(root_directory)
        @root_directory = root_directory
      end
      
      def add_ruby_source(path)
        @ruby_sources << File.expand_path(path, root_directory)
      end
      
      def add_prepended_js_source(path)
        @prepended_js_sources << File.expand_path(path, root_directory)
      end
      
      def add_appended_js_source(path)
        @appended_js_sources << File.expand_path(path, root_directory)
      end
      
      def build_directory=(new_build_directory)
        @build_directory = File.expand_path(new_build_directory, root_directory)
      end
      
      def build_mode=(new_build_mode)
        new_build_mode = new_build_mode.to_s
        raise 'build mode not valid' unless ['production', 'development'].include?(new_build_mode)
        @build_mode = new_build_mode
      end
      
      def output=(new_output)
        @output = File.expand_path(new_output, root_directory)
      end
      
      def mruby_directory=(new_mruby_directory)
        mruby_directory = File.expand_path(new_mruby_directory, root_directory)
        raise "'mruby_directory' not found" unless File.directory?(mruby_directory)
        @mruby_directory = mruby_directory
      end
      
      def add_gem(path)
        path = File.expand_path(path, root_directory)
        raise "gem #{path} not found" unless File.directory?(path)
        @gems << path
      end
    
    end
  end
end
