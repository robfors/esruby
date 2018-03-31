module ESRuby
  class Build
    extend Forwardable
    
    class << self
      attr_reader :build
    end
    
    def self.new(*args)
      raise 'can only build one project at a time' if @build
      new_build = super
      @build = new_build
      new_build
    end
    
    def_delegators :@configuration, :project_directory, :build_directory,
      :build_mode, :output, :mruby_directory, :gems
    
    def initialize(&block)
      @configuration = Configuration.new
      @configuration.instance_eval(&block)
    end
    
    def build
      FileUtils.mkdir_p(build_directory)
      build_mruby_config
      build_mruby
      load_gems
      build_app
    end
    
    def gem_directory
      ESRuby.gem_directory
    end
    
    def load_gems
      gem_paths = JSON.parse(File.read(gem_paths_file))
      gem_paths.each do |gem_path|
        esruby_spec_path = "#{gem_path}/esruby_gem"
        load(esruby_spec_path) if File.file?(esruby_spec_path)
      end
      nil
    end
    
    def gem_paths_file
      "#{build_directory}/gem_paths.json"
    end
    
    def prepended_js_sources
      js_files = []
      Gem::Specification.specifications.each do |specification|
        js_files += specification.prepended_js_sources
      end
      js_files += @configuration.prepended_js_sources
      js_files
    end
    
    def appended_js_sources
      js_files = []
      Gem::Specification.specifications.each do |specification|
        js_files += specification.appended_js_sources
      end
      js_files += @configuration.appended_js_sources
      js_files
    end
    
    def ruby_sources
      @configuration.ruby_sources + ["#{gem_directory}/resources/rb/append.rb"]
    end
    
    def build_mruby_config
      template = File.read("#{gem_directory}/resources/build_config.eruby")
      eruby = Erubis::Eruby.new(template)
      config = {}
      config[:optimization_argument] = optimization_argument
      config[:closure_argument] = closure_argument
      config[:debug_argument] = debug_argument
      config[:build_directory] = build_directory
      config[:project_directory] = project_directory
      config[:gems] = gems
      config[:gem_paths_file] = gem_paths_file
      new_output = eruby.result(config)
      output_path = "#{build_directory}/build_config.rb"
      old_output = File.read(output_path) if File.exists?(output_path)
      File.write(output_path, new_output) if (old_output != new_output) # only write if updated
      ENV["MRUBY_CONFIG"] = output_path # used by the mruby build process
    end
    
    def optimization_argument
      case build_mode
      when 'production'
        "-O2"
      when 'development'
        "-O0"
      else
        raise
      end
    end
    
    def debug_argument
      case build_mode
      when 'production'
        "-g0"
      when 'development'
        ""
      else
        raise
      end
    end
    
    def closure_argument
      #"--closure 0"
      ""
    end
    
    def build_mruby
      Dir.chdir(mruby_directory) do
        RakeFileUtils.sh "rake"
      end
    end
    
    def build_app
      mrbc = "#{build_directory}/host/bin/mrbc"
      js_arguments = prepended_js_sources.map { |path| "--pre-js #{path}" }.join(" ")
      js_arguments += " "
      js_arguments += appended_js_sources.map { |path| "--post-js #{path}" }.join(" ")
      RakeFileUtils.sh "#{mrbc} -B app -o #{build_directory}/app.c #{ruby_sources.join(" ")}"
      RakeFileUtils.sh "emcc --bind -I #{mruby_directory}/include #{build_directory}/app.c -o #{build_directory}/app.o #{build_directory}/emscripten/lib/libmruby.a -lm #{js_arguments} #{optimization_argument} #{closure_argument} #{debug_argument}"
      RakeFileUtils.sh "emcc -std=c++11 --bind -I #{mruby_directory}/include #{gem_directory}/resources/cpp/main.cpp -o #{build_directory}/main.o #{build_directory}/emscripten/lib/libmruby.a -lm #{js_arguments} #{optimization_argument} #{closure_argument} #{debug_argument}"
      RakeFileUtils.sh "emcc --bind -I #{mruby_directory}/include -o #{build_directory}/output.js #{build_directory}/app.o #{build_directory}/main.o #{build_directory}/emscripten/lib/libmruby.a -lm #{js_arguments} #{optimization_argument} #{closure_argument} #{debug_argument}"
      #if build.build_mode == 'production'
      # ENV["EMCC_CLOSURE_ARGS"] = "--language_in=ECMASCRIPT6" #possibly allow setting output: --language_out=ECMASCRIPT6
      #  sh "java -jar #{PROJECT_DIRECTORY}/emsdk/emscripten/incoming/third_party/closure-compiler/compiler.jar --js #{build.absolute_build_directory}/output.js --js_output_file #{build.absolute_output}"
      #else
        FileUtils.cp("#{build_directory}/output.js", "#{output}")
      #end
      #--language_in=ECMASCRIPT6
    end
    
  end
end
