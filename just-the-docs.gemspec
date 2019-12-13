# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "takeaways"
  spec.version       = "0.2.7"
  spec.authors       = ["Haemin Ryu"]
  spec.email         = ["happygoals95@gmail.com"]

  spec.summary       = %q{Hello Wendy.}
  spec.homepage      = "https://github.com/happygoals/takeaways"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|bin|_layouts|_includes|lib|Rakefile|_sass|LICENSE|README)}i) }
  spec.executables   << 'takeaways'

  spec.add_runtime_dependency "jekyll", "~> 3.8.5"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.0"
  spec.add_runtime_dependency "rake", "~> 12.3.1"

  spec.add_development_dependency "bundler", "~> 2.0.1"
end
