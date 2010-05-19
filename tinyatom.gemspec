# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tinyatom}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew M. Boedicker"]
  s.date = %q{2010-05-18}
  s.description = %q{Small and easy to use ruby Atom feed generator.}
  s.email = %q{matthewm@boedicker.org}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".gitignore",
     "COPYING",
     "README.textile",
     "Rakefile",
     "VERSION",
     "lib/tinyatom/feed.rb",
     "lib/tinyatom/tinyatom.rb",
     "lib/tinyatom/uri.rb"
  ]
  s.homepage = %q{http://github.com/mmb/tinyatom}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Small and easy to use ruby Atom feed generator.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
  end
end

