Gem::Specification.new do |s|
  s.name        = 'esruby'
  s.version     = '0.1.4'
  s.date        = '2018-03-31'
  s.summary     = 'Ruby running in the browser'
  s.description = 'This project brings mruby to the browser. It uses emscripten to compile the mruby source code into JavaScript (ECMAScript) and runs in the browser.'
  s.authors     = ['Rob Fors']
  s.email       = ['mail@robfors.com']
  s.files       = Dir.glob("{bin,lib,resources}/**/*") + %w(LICENSE README.md)
  s.executables = ['esruby']
  s.homepage    = 'https://github.com/robfors/esruby'
  s.license     = 'MIT'
  s.add_runtime_dependency "erubis", "~>2.7"
end
