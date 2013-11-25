module Leech
  class Teacher < Actor


    def teach(student, victim, method)
      student.victims[method] = Victim.new(victim, student)
    end

  end
end