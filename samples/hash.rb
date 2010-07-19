#!/usr/bin/ruby 

# just for testing
$LOAD_PATH << (File.dirname(__FILE__) + '/../../blox/lib')
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib/')

require 'pattern_match'

class << self
  include PatternMatch
end

def hm(a)
  match(a) do
    pattern(Hash(:x => 'some value')) { |b| puts b[:x] }
    pattern(Hash((L :x) => :y)) { |b| puts b[:y] }
  end  
end

hm 'some key' => 'some value'
hm :x => 'value'
