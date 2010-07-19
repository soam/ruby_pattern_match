#!/usr/bin/ruby 

# just for testing
$LOAD_PATH << (File.dirname(__FILE__) + '/../../blox/lib')
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib/')

require 'pattern_match'

class << self
  include PatternMatch
end

def pm_length(a)
  # A stupid way to do a.length
  match(a) do
    pattern([]) { 0 }
    pattern(Cons(:_, :xs)) { |b| 1 + pm_length(b[:xs]) }
  end  
end


p pm_length([1,2,3])
