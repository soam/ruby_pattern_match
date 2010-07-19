#!/usr/bin/ruby 

# just for testing
$LOAD_PATH << (File.dirname(__FILE__) + '/../../blox/lib')
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib/')

require 'pattern_match'

class << self
  include PatternMatch
end

class Expr
  attr_accessor :op, :e1, :e2
  def initialize(op, e1, e2)
    @op = op
    @e1 = e1
    @e2 = e2
  end
  def to_s
    "(#{op} #{e1} #{e2})"
  end
end


def simplify(e)
  match(e) {
    pattern(Or(Fixnum, Symbol)) { e }

    # additive identity.  This attr pattern calls e.op and matches the
    # result against (L :add), and calls e.e1 and matches it against
    # the constant 0.
    pattern(Attr :op => (L :add), :e1 => 0) { simplify e.e2 }
    pattern(Attr :op => (L :add), :e2 => 0) { simplify e.e1 }

    # multiplicative identity
    pattern(Attr :op => (L :mul), :e1 => 1) { simplify e.e2 }
    pattern(Attr :op => (L :mul), :e2 => 1) { simplify e.e1 }

    pattern(Expr) { Expr.new(e.op, simplify(e.e1), simplify(e.e2)) }
  }
end

e = Expr.new(:mul, 
             1, 
             Expr.new(:mul, 
                      Expr.new(:add, 42, 0), 
                      Expr.new(:add, :x, 2)))

puts "Original: #{e}"
puts "Simplified: #{simplify e}"

