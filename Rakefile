begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'tinyatom'
    gemspec.summary = 'Small and easy to use ruby Atom feed generator.'
    gemspec.description = gemspec.summary
    gemspec.email = 'matthewm@boedicker.org'
    gemspec.homepage = 'http://github.com/mmb/tinyatom'
    gemspec.authors = ['Matthew M. Boedicker']
    %w{
      builder 2.1.2
     }.each_slice(2) { |g,v| gemspec.add_dependency(g, ">= #{v}") }
    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
