module Leech
  module Student
    attr_accessor :method_register
    attr_accessor :surrogate_register
    
    def extended(base)
      base.surrogate_register = {}
      base.method_register = {}
    end
    
    def add_method(method, victim)
      surrogate = (self.surrogate_register[victim.object_id] ||= Surrogate.new(self, victim))
      surrogate.copy_method(method)
    end
    
    def method_missing(method, *args)
      if surrogate = surrogates[method]
        surrogate.execute(method, )
      else
        super(*args)
      end
    end
    
    def registered?
      true
    end
  end
end