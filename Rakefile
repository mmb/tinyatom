begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'tinyatom'
    gemspec.summary = 'Small and easy to use ruby Atom feed generator.'
    gemspec.description = gemspec.summary
    gemspec.email = 'matthewm@boedicker.org'
    gemspec.homepage = 'http://github.com/mmb/tinyatom'
    gemspec.authors = ['Matthew M. Boedicker']
    gemspec.license = 'MIT'

    %w{
      builder ~> 2.0
      public_suffix_service ~> 0.0
     }.each_slice(3) { |g,o,v| gemspec.add_dependency(g, "#{o} #{v}") }
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
