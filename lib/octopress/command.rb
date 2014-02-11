module Octopress
  class Command
    def self.inherited(base)
      subclasses << base
    end

    def self.subclasses
      @subclasses ||= []
    end

    def init_with_program(p)
      raise NotImplementedError.new("")
    end
  end
end
