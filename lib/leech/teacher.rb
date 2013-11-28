require 'leech/actor'
require 'leech/student'

module Leech
  module Teacher
    def teach(student, victim, method)
      register(student) unless registered?(student)
      add_method(student, victim, method)
      student
    end

    private
    def add_method(student, victim, method)
      if victim.respond_to?(method)
        surrogate = (student.surrogate_register[victim.object_id] ||= Surrogate.new(student, victim))
      elsif registered?(victim)
        surrogate = (student.surrogate_register[victim.object_id] ||= victim.get_surrogate(method).clone)
        surrogate.host = student
        surrogate.victim = surrogate.victim.clone
      end

      if surrogate
        surrogate.copy_methods
        student.method_register[method] = victim.object_id
      else
        raise "method not found on victim"
      end
    end

    def register(object)
      object.extend(Leech::Student)
    end

    def registered?(object)
      object.respond_to?(:student?)
    end
  end
end