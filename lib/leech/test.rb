class Twerp < Leech::Actor

  def say_name
    "my name is #{name}"
  end

  def wibble
    "wibble"
  end

end

jones = Leech::Teacher.new("Mr Jones")
bob = Leech::Actor.new("Bob")
elvis = Twerp.new("Elvis")
john = Leech::Actor.new("John")
jones.teach(bob, elvis, :say_name)
jones.teach(john, bob, :say_name)

