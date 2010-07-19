require 'blox'

require 'pattern_match/pattern'
require 'pattern_match/matchbinding'
require 'pattern_match/matchfunc'

module PatternMatch

class HashPattern < Pattern
  def self.command_name
    "Hash" 
  end
  
  # return a binding (as a hash) or nil
  def pmatch(subject)
    return nil unless (Hash === subject)
    
    b = MatchBinding.new

    # this pattern is successful iff each key value pair in it
    # successfully matches some key value pair in the subject.
    n_matched = 0

    patternhash = @args[0]

    patternhash.each { |pk,pv|
      if pk.instance_of? Literal # special case this to avoid linear search
        realkey = pk.val

        return nil unless (subject.has_key? realkey)
        bb = PatternMatch::matchfunc(pv, subject[realkey])
        return nil if !bb

        b.mix bb
          
        # match succeeded
        n_matched += 1
      else
        # Search for a key matching the pattern.  Search is in arbitrary order.
        subject.each { |sk,sv|
          key_b = PatternMatch::matchfunc(pk, sk)
          next if !key_b

          val_b = PatternMatch::matchfunc(pv, sv)
          next if !val_b
          
          b.mix key_b
          b.mix val_b

          # match succeeded, stop searching
          n_matched += 1
          break
        }
      end
    }

    return nil if (n_matched < @args.size)

    b
  end
end

end
