require 'blox'

module PatternMatch

# pattern <pattern> <block>
class PatternBlock < Blox::BlockCommand
  def self.command_name
    "pattern"
  end  

  def check_args
    raise "Missing pattern" if @args.length < 1
  end

  def visit_before_block
    @pattern = @args[0]
  end

  def call_block
    # nothing -- dont run the block
  end

  attr_reader :pattern, :block

end

end
