require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class Cons < Pattern
  def check_args
    if (@args.length != 2)
      raise "Cons needs exactly two arguments"
    end
  end
  
  # return a binding (as a hash) or nil
  def pmatch(subject)
    return nil unless (Array === subject)

    # match subject head to pattern's first part
    return nil if (subject.length == 0)
    head_binding = PatternMatch::matchfunc(@args[0], subject[0])
    return nil if !head_binding

    # match subject tail to pattern's second part
    tail_binding = PatternMatch::matchfunc(@args[1], subject[1, subject.length - 1])
    return nil if !tail_binding
    
    b = MatchBinding.new
    b.mix(head_binding)
    b.mix(tail_binding)
    b
  end

end
end
