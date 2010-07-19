#!/usr/bin/ruby 

# just for testing
$LOAD_PATH << (File.dirname(__FILE__) + '/../../blox/lib')
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib/')

require 'pattern_match'

class << self
  include PatternMatch
end

class Foo
  attr_accessor :a

  def initialize(a)
    @a = a
  end
end


def f(o)
  match(o) {
    pattern(Attr :a => 42) { puts "a is 42" }
    pattern(:_) { puts "a is something else" }
  }
end

f Foo.new(42)
f Foo.new(11)
