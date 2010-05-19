Dir.glob(File.join(File.dirname(__FILE__), 'tinyatom', '*.rb')).
  map { |f| File.join('tinyatom', File.basename(f, '.rb')) }.
  sort.
  each { |m| require m }
