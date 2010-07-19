require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class Or < Pattern
  def pmatch(subject)
    @args.each { |p|
      b = PatternMatch::matchfunc(p, subject)
      if b
        return b
      end
    }
    nil
  end

end
end
