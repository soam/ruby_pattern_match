require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class Literal < Pattern
  def check_args
    raise "Need exactly one argument" if (@args.length != 1)
  end

  # so that other patterns can look at the value of the literal
  def val
    @args[0]
  end

  # return a binding (as a hash) or nil
  def pmatch(subject)
    # this pattern match succeeds iff the subject equals the pattern.
    # No bindings result.
    if (subject == @args[0])
      MatchBinding.new
    else
      nil
    end
  end

end
end
