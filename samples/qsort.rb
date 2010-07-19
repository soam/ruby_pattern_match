#!/usr/bin/ruby 

# just for testing
$LOAD_PATH << (File.dirname(__FILE__) + '/../../blox/lib')
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib/')

require 'pattern_match'

class << self
  include PatternMatch
end

def qsort(a)
  match(a) do

    pattern([]) { [] }

    pattern(Cons(:x, :xs)) { |b| 
      (qsort b[:xs].find_all { |e| e < b[:x] }) +
      [b[:x]] + 
      (qsort b[:xs].find_all { |e| e >= b[:x] })
    }
  end  
end


p qsort [3,2,1]
