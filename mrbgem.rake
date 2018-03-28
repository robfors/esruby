MRuby::Gem::Specification.new('esruby-esruby') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Rob Fors'
  spec.summary = 'dependency for the esruby interpreter'
  
  spec.add_dependency('mruby-eval')
  
  spec.cxx.flags << "-std=c++11"
  
  spec.compilers.each do |c|
    c.flags << "--bind"
  end
  
end
