require 'erubis'
require 'fileutils'
require 'forwardable'
require 'rake'
require 'json'

require_relative "esruby/build.rb"
require_relative "esruby/build/configuration.rb"
require_relative "esruby/gem.rb"
require_relative "esruby/gem/specification.rb"

module ESRuby

  def self.gem_directory
    "#{File.dirname(__FILE__)}/.."
  end
  
  def self.new(project_path)
    FileUtils.mkdir_p(project_path)
    FileUtils.cp_r("#{gem_directory}/resources/project_template/.", project_path)
    nil
  end

  def self.clean
    build = ESRuby::Build.build
    FileUtils.rm_rf(build.build_directory)
    nil
  end
  
  def self.build
    ESRuby::Build.build.build
    nil
  end
  
end
