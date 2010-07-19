require 'blox'

class Pattern < Blox::Command
  def self.command_name
    self.to_s.split("::").last
  end
  
  def notify_parent
    # no-op
  end
end
