require 'blox'

Dir.glob(File.dirname(__FILE__) + '/pattern_match/**/*.rb') { |file| 
  require file
}

module PatternMatch
  Blox::create_language(self, PatternMatch)

  # shorthand for Literal, will probably be commonly used
  alias_method :L, :Literal
end
