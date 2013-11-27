module Leech
  class Teacher < Actor
    def teach(student, victim, method)
      register(student) unless registered?(student)
      student.add_method(method, victim)
      student
    end
    
    def register(student)
      student.extend(Leech::Student)
    end
    
    private
    def registered?(student)
      student.respond_to?(:registered?)
    end
  end
end