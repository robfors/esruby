# This file sets up the build environment for a webruby project.
ESRuby::Build.new do |conf|

  conf.project_directory = File.dirname(__FILE__)
  
  conf.add_ruby_source 'app/app.rb'  
  #conf.add_prepended_js_source 'app/prepend.js'
  #conf.add_appended_js_source 'app/append.js'
  
  # By default, the build output directory is "build/"
  conf.build_directory = 'build'

  # note: dont change this yet
  # Use :production for O2 mode build, and :development for O0 mode.
  # Or you can not yet use '-O0', '-O1', '-O2', '-O3', etc. directly
  # note :production mode is still having trouble working
  #conf.build_mode = :production
  conf.build_mode = :development

  # set the final output file name
  conf.output = "www/app.js"
  
  # to override the mruby version, then specify your copy here
  #conf.mruby_directory = 'mruby'
  
  # note: dont change this yet
  # We found that if memory init file is used, browsers will hang
  # for a long time without response. As a result, we disable memory
  # init file by default. However, you can test this yourself
  # and re-enable it by commenting/removing the next line.
  #conf.ldflags << "--memory-init-file 0"
  
  # JavaScript binding interface
  # see: https://github.com/robfors/esruby-bind for more info
  # conf.add_gem :github => 'robfors/esruby-bind'
  
end
