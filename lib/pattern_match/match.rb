require 'blox'

require 'pattern_match/matchfunc'

module PatternMatch

class Match < Blox::BlockCommand

  def visit_after_block
    
    raise "match(): need an object to match against" if @args.length < 1

    subject = @args[0]

    @children.each { |child|
      binding = PatternMatch::matchfunc(child.pattern, subject)

      if binding
        if $PM_TRACE
          puts "Pattern matched at #{child.source_location}"
        end 

        if (child.block.arity < 1)
          ret = child.block.call
        elsif child.block.arity == 1
          ret = child.block.call(binding)
        else 
          raise "Block must take zero or one argument (but takes #{child.block.arity} instead)"
        end
        return ret
      end
    }
    return nil
  end

end

end
