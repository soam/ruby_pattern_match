require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class And < Pattern
  def pmatch(subject)
    b = MatchBinding.new
    @args.each { |p|
      bb = PatternMatch::matchfunc(p, subject)
      return nil if !bb
      b.mix bb
    }
    b
  end
end
end
