#!/usr/bin/ruby 

# just for testing
$LOAD_PATH << (File.dirname(__FILE__) + '/../../blox/lib')
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib/')

require 'pattern_match'

class << self
  include PatternMatch
end

def foo(a)
  match(a) do
    # will throw a "duplicate key in pattern" error
    pattern Cons(:x, :x) {}
  end  
end


foo [1,2]

