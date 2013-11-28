require 'leech/surrogate'

module Leech
  module Student
    attr_accessor :method_register
    attr_accessor :surrogate_register

    def self.extended(base)
      base.surrogate_register = {}
      base.method_register = {}
    end

    def method_missing(method, *args)
      if surrogate = get_surrogate(method)
        surrogate.send(method, *args)
      else
        super(method, *args)
      end
    end

    def student?
      true
    end

    def get_surrogate(method)
      surrogate_register[method_register[method]]
    end
  end
end