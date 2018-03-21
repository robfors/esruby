# This file sets up the build environment for a webruby project.
ESRuby::Build.new do |conf|

  conf.root_directory = File.dirname(__FILE__)
  
  conf.add_ruby_source 'app/app.rb'  
  #conf.add_prepended_js_source 'app/prepended.js'
  #conf.add_appended_js_source 'app/appended.js'
  
  # By default, the build output directory is "build/"
  conf.build_directory = 'build'

  # Use 'release' for O2 mode build, and everything else for O0 mode.
  # Or you can also use '-O0', '-O1', '-O2', '-O3', etc. directly
  #conf.build_mode = :production
  conf.build_mode = :development

  # By default the final output file name is "webruby.js"
  conf.output = "www/app.js"
  
  #conf.mruby_directory = 'mruby'
  
  # We found that if memory init file is used, browsers will hang
  # for a long time without response. As a result, we disable memory
  # init file by default. However, you can test this yourself
  # and re-enable it by commenting/removing the next line.
  #conf.ldflags << "--memory-init-file 0"
  
  # JavaScript calling interface
  #conf.gem :git => 'git://github.com/xxuejie/mruby-js.git', :branch => 'master'
  
  # conf.add_gem 'gems/esruby-bind'
  
end
