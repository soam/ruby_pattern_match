require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class Attr < Pattern
  def check_args
    if ((@args.length != 1) and !(@args[0].is_a? Hash))
      raise "Attr needs one argument, which should be a Hash" 
    end
  end

  # Attr(:blah => "32")
  def pmatch(subject)
    pattern_hash = @args[0]
    
    b = MatchBinding.new
    pattern_hash.each { |field, p|
      f = subject.__send__(field)
      bb = PatternMatch::matchfunc(p, f)
      return nil if !bb
      b.mix bb
    }
    b
  end
end
end
