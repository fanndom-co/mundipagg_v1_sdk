Gem::Specification.new do |s|
  s.name        = 'mundipagg_v1'
  s.version     = '0.0.3'
  s.date        = '2017-05-19'
  s.summary     = "New mundipagg api"
  s.description = "New mundipagg api"
  s.authors     = ["Marmotex"]
  s.email       = 'admin@marmotex.com'
  s.files       = Dir.glob("{bin,lib}/**/*{.rb}")
  s.test_files = ["spec/mundipagg_v1_sdk_spec.rb"]
  s.homepage    =
    'http://rubygems.org/gems/mundipagg_v1_sdk'
  s.license       = 'MIT'
  s.add_development_dependency 'bundler'
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rest-client"
end
