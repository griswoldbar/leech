module Leech
  class Surrogate
    attr_accessor :host, :victim

    def initialize(h, v)
      self.host = h
      self.victim = v.clone
    end

    def copy_methods
      _host = host
      common_methods.each do |method|
        victim.define_singleton_method(method) do |*args|
          _host.__send__(method, *args)
        end
      end
    end

    def method_missing(method, *args)
      if victim.respond_to?(method)
        victim.__send__(method, *args)
      else
        super(method, *args)
      end
    end

    private
    def common_methods
      ((host.methods + host.private_methods(false)) & (victim.methods + victim.private_methods(false))) - Object.instance_methods
    end
  end
end