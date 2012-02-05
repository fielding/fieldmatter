# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fieldmatter/version"

Gem::Specification.new do |s|
  s.name        = "fieldmatter"
  s.version     = FieldMatter::VERSION
  s.authors     = ["Fielding Johnston"]
  s.email       = ["fielding@justfielding.com"]
  s.homepage    = 'https://github.com/justfielding/fieldMatter'
  s.summary     = "taxonomy with redis and extended attributes"
  s.description = "Library used in the fieldnote personal content management system. I wrote this library to assist in accessing extended attributes from support operating systems and then transferring them, despite the git backend, to the fieldnote server. Once there they are stored in a redis database for further manipulation."

  s.rubyforge_project = "fieldmatter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("grit", "~>2.4")
  s.add_dependency("json", "~>1.6")
  s.add_dependency("ohm", "~>0.1.3")
  s.add_dependency("ohm-contrib", "~>0.1.2")

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

end