module ESRuby
  class Build
    class Configuration
    
      attr_reader :ruby_sources, :prepended_js_sources, :appended_js_sources,
        :build_mode, :gems, :mruby_directory, :output_name
      
      attr_accessor :flags
      
      def initialize
        @project_directory = nil
        @build_directory = nil
        @mruby_directory = "#{ESRuby.gem_directory}/resources/mruby"
        @output_name = 'app'
        @output_directory = 'output'
        @ruby_sources = []
        @prepended_js_sources = []
        @appended_js_sources = []
        @gems = []
        @flags = []
      end
      
      def project_directory
        raise "'project_directory' not set" unless @project_directory
        @project_directory
      end
      
      def project_directory=(new_project_directory)
        new_project_directory = File.expand_path(new_project_directory)
        raise "'project_directory' not found" unless File.directory?(new_project_directory)
        @project_directory = new_project_directory
      end
      
      def add_ruby_source(path)
        @ruby_sources << File.expand_path(path, project_directory)
      end
      
      def add_prepended_js_source(path)
        @prepended_js_sources << File.expand_path(path, project_directory)
      end
      
      def add_appended_js_source(path)
        @appended_js_sources << File.expand_path(path, project_directory)
      end
      
      def build_directory
        @build_directory || File.expand_path('build', project_directory)
      end
      
      def build_directory=(new_build_directory)
        @build_directory = File.expand_path(new_build_directory, project_directory)
      end
      
      def build_mode=(new_build_mode)
        new_build_mode = new_build_mode.to_s
        raise 'build mode not valid' unless ['production', 'development'].include?(new_build_mode)
        @build_mode = new_build_mode
      end
      
      def output_name=(new_output_name)
        raise ArgumentError, "'new_output_name' must respond to #to_s" unless new_output_name.respond_to?(:to_s)
        @output_name = new_output_name.to_s
      end
      
      def output_directory
        File.expand_path(@output_directory, project_directory)
      end
      
      def output_directory=(new_output_directory)
        raise ArgumentError, "'new_output_directory' must respond to #to_s" unless new_output_directory.respond_to?(:to_s)
        @output_directory = new_output_directory.to_s
      end
      
      def mruby_directory=(new_mruby_directory)
        new_mruby_directory = File.expand_path(new_mruby_directory, project_directory)
        raise "'mruby_directory' not found" unless File.directory?(new_mruby_directory)
        @mruby_directory = new_mruby_directory
      end
      
      def add_gem(arg)
        if arg.is_a?(String)
          arg = File.expand_path(arg, project_directory)
          raise "gem #{arg} not found" unless File.directory?(arg)
        end
        @gems << arg
      end
    
    end
  end
end
