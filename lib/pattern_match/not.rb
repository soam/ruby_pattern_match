require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class Not < Pattern
  def check_args
    raise "Not needs exactly one argument" if @args.length != 1
  end

  def pmatch(subject)
    b = PatternMatch::matchfunc(@args[0], subject)
    if b
      nil
    else
      MatchBinding.new
    end
  end

end
end
