require 'erubis'
require 'fileutils'
require 'forwardable'
require 'rake'

require_relative "esruby/build.rb"
require_relative "esruby/build/configuration.rb"
require_relative "esruby/gem.rb"
require_relative "esruby/gem/specification.rb"

module ESRuby

  def self.gem_directory
    "#{File.dirname(__FILE__)}/.."
  end

  def self.clean
    build = ESRuby::Build.build
    FileUtils.rm_rf(build.build_directory)
  end
  
  def self.build
    ESRuby::Build.build.build
  end
  
end
