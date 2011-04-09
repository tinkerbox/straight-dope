# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "straight_dope/version"

Gem::Specification.new do |s|
  s.name        = "straight_dope"
  s.version     = StraightDope::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jaryl Sim"]
  s.email       = ["jaryl@tinkerbox.com.sg"]
  s.homepage    = "http://www.tinkerbox.com.sg"
  s.summary     = %q{Convert page URLs to media URLs}
  s.description = %q{Straight Dope gest the actual URL for media content that is usually hidden behind a page.}

  s.rubyforge_project = "straight_dope"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
