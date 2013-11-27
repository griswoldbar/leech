module Leech
  class Surrogate
    attr_reader :host, :victim
    
    def initialize(host, victim)
      @host = host
      @victim = victim.clone
    end
    
    def copy_methods
      _host = host
      common_methods.each do |method|
        victim.define_singleton_method(method) do |*args|
          _host.send(method, *args)
        end
      end
    end
    
    def method_missing(method, *args)
      if victim.respond_to?(method)
        victim.send(method, *args)
      else
        super(method, *args)
      end
    end
    
    private
    def common_methods
      (host.methods & victim.methods) - Object.instance_methods
      # (host.methods(false) & victim.methods(false) & host.private_methods(false) & victim.private_methods(false))
    end
  end
end
# module Leech
#   class Victim
#     attr_reader :subject, :student
# 
#     def initialize(subject, student)
#       @subject = subject.dup
#       @student = student
#     end
# 
#     def invoke(method, *args, &block)
#       possess unless possessed?
# 
#       subject.send(method, *args, &block)
#     end
# 
#     private
#     def possess
#       _student = student
# 
#       common_methods.each do |method|
#         subject.define_singleton_method(method) do |*args|
#           _student.send(method, *args)
#         end
#       end
# 
#       @possessed = true
#     end
# 
#     def possessed?
#       @possessed == true
#     end
# 
#     def common_methods
#       (student.methods & subject.methods) - Object.instance_methods
#     end
#   end
# end