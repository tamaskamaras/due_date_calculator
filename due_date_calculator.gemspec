Gem::Specification.new do |gem_spec|
  gem_spec.name          = 'due_date_calculator'
  gem_spec.version       = '0.0.1'
  gem_spec.date          = '2021-01-28'
  gem_spec.summary       = 'Due Date Calculator'
  gem_spec.description   = 'Define deadlines within only work time'
  gem_spec.authors       = ['Tamas Kamaras']
  gem_spec.email         = 'kamaras.tamas.viktor@gmail.com'
  gem_spec.homepage      = 'https://github.com/tamaskamaras/due_date_calculator'
  gem_spec.license       = 'MIT'
  gem_spec.files         = [
    'Gemfile',
    'app/due_date_calculator.rb'
  ]
  gem_spec.require_paths = ['app', 'spec']
  gem_spec.metadata      = {
    'source_code_uri' => 'https://github.com/tamaskamaras/due_date_calculator.git'
  }
  gem_spec.add_runtime_dependency('time')
  gem_spec.add_development_dependency('rspec', '~> 3.10', '>= 3.10.0')
end
