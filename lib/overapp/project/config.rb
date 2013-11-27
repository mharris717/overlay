module Overapp
  class ProjectConfig
    include FromHash
    attr_accessor :body, :base_ops
    fattr(:overapps) { [] }
    fattr(:vars) { {} }

    def base(*args)
      overapp(*args)
    end

    def overapp(name,ops={})
      self.overapps << ConfigEntry.new(:descriptor => name, :type => :overapp, :entry_ops => ops)
    end

    def overlay(*args)
      overapp(*args)
    end

    def command(cmd,ops={})
      self.overapps << ConfigEntry.new(:descriptor => cmd, :type => :command, :entry_ops => ops)
    end

    def var(k,v)
      vars[k] = v
    end

    def load!
      c = self
      eval(body)
    end
  end
end