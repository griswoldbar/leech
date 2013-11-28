require 'leech/teacher'

module Leech
  module Trainer
    attr_accessor :victim_register

    def self.extended(base)
      base.victim_register = {}
      base.extend(Leech::Teacher)

      base.instance_eval do
        def new(*args)
          super.tap do |instance|
            victim_register.each_pair do |method, victim|
              teach(instance, victim, method)
            end
          end
        end
      end
    end
  end
end