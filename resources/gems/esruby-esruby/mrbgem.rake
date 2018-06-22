MRuby::Gem::Specification.new('esruby-esruby') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Rob Fors'
  spec.summary = 'dependency for the esruby interpreter'
  spec.version = '0.1.0'

  spec.add_dependency('mruby-print') ## temp
  spec.add_dependency('mruby-eval')
  
  spec.cxx.flags << "-std=c++11"
  
  spec.compilers.each do |c|
    c.flags << "--bind"
  end
  
  spec.rbfiles = []
  spec.rbfiles << "#{dir}/mrblib/esruby.rb"
    
end
