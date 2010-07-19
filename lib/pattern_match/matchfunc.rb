require 'pattern_match/matchbinding'

module PatternMatch

def self.matchfunc(pattern, subject)
  if pattern.respond_to? :pmatch
    return pattern.pmatch(subject)
  elsif Symbol === pattern
    # always succeeds
    b = MatchBinding.new
    unless pattern == :_ # the "dont care" pattern, don't bind anything
      b[pattern] = subject
    end
    return b
    
  elsif (pattern.respond_to? :===)
    (pattern === subject) ? MatchBinding.new : nil

  else
    raise "Cannot understand pattern #{pattern.inspect}"

  end
end

end
