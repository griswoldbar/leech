module Leech
  class Victim
    attr_reader :subject, :student

    def initialize(subject, student)
      @subject = subject.dup
      @student = student
    end

    def invoke(method, *args, &block)
      possess unless possessed?

      subject.send(method, *args, &block)
    end

    private
    def possess
      _student = student

      common_methods.each do |method|
        subject.define_singleton_method(method) do |*args|
          _student.send(method, *args)
        end
      end

      @possessed = true
    end

    def possessed?
      @possessed == true
    end

    def common_methods
      (student.methods & subject.methods) - Object.instance_methods
    end
  end
end