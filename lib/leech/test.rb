class Twerp < Leech::Actor

  def say_name
    "my name is #{name}"
  end

  def wibble
    "wibble"
  end

end

teacher = Leech::Teacher.new("Mr Jones")
student = Leech::Student.new("Bob")
twerp = Twerp.new("Elvis")
teacher.teach(student, twerp, :say_name)
