
list = Dir.glob(File.expand_path(File.dirname(__FILE__) + "/extension/*.rb")).sort
list.each { |f|
  require f unless f == __FILE__
}