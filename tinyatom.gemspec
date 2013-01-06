# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'tinyatom'
  s.version = '0.3.5'
  s.summary = 'Small and easy to use ruby Atom feed generator'
  s.description = s.summary
  s.homepage = 'https://github.com/mmb/tinyatom'
  s.authors = ['Matthew M. Boedicker']
  s.email = %w{matthewm@boedicker.org}
  s.license = 'MIT'

  %w{
    builder > 0
    public_suffix > 0
    }.each_slice(3) { |g,o,v| s.add_dependency(g, "#{o} #{v}") }

  s.files = `git ls-files`.split("\n")
end
