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
    pattern([]) { puts "empty list" }
    pattern(Literal :x) { puts "literally :x" }
    pattern(Hash L(:x) => :y) { |b| puts b[:y] }
    pattern(:_) { puts "default case" }
  end  
end


foo :x

foo :x => 32

foo "blah"
