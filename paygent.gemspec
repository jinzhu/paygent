# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "paygent"
  s.version     = "0.0.3"
  s.authors     = ["Jinzhu"]
  s.email       = ["wosmvp@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby wrapper for paygent}
  s.description = %q{Ruby wrapper for paygent}

  s.rubyforge_project = "paygent"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "curb"
end
