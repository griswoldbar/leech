class Twerp < Leech::Actor
  def say_name
    "my name is #{name}"
  end
end

jones = Leech::Actor.new("Mr Jones")
jones.extend(Leech::Teacher)
jones.extend(Leech::TrainerTeacher)


bob = Leech::Actor.new("Bob")
elvis = Twerp.new("Elvis")
john = Leech::Actor.new("John")

jones.teach(bob, elvis, :say_name)
jones.teach(john, bob, :say_name)

def bob.size
  "my name has #{name.size} letters"
end

mike = Leech::Actor.new("Mike")

def mike.letter
  "my name starts with #{name[0]}"
end

jones.train(Twerp, mike, :letter)
jones.train(Twerp, bob, :size)

