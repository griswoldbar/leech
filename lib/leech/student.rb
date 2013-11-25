module Leech
  class Student < Actor

    def victims
      @victims ||= {}
    end

    def method_missing(method, *args, &block)
      if victim = self.victims[method]
        victim.invoke(method, *args, &block)
      else
        super(method, *args, &block)
      end
    end
  end
end