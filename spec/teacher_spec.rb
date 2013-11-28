require 'spec_helper'
require 'leech/teacher'

describe Leech::Teacher do
  let(:teacher) { Leech::Teacher.new('Mr Jones') }
  class Speaker < Leech::Actor
    def say_name
      "my name is #{name}"
    end

    def say_secret
      secret
    end

    private
    def secret
      "i killed kennedy"
    end
  end

  class Man < Leech::Actor
    private
    def secret
      "i am elvis"
    end
  end

  class Idiot < Leech::Actor
    private
    def secret
      "i am a woman"
    end
  end

  let(:jim) { Speaker.new("Jim") }
  let(:bob) { Man.new("Bob") }
  let(:tom) { Idiot.new("Tom") }

  describe "teaching methods from one object to another" do
    describe "singleton methods" do

    end

    describe "instance methods" do
      it "teaches the method and preserves the student's instance variables" do
        teacher.teach(bob, jim, :say_name)
        expect(bob.say_name).to eql("my name is Bob")
        expect(jim.say_name).to eql("my name is Jim")
      end

      it "preserves the student's private methods" do
        teacher.teach(bob, jim, :say_secret)
        expect(bob.say_secret).to eql("i am elvis")
        expect(jim.say_secret).to eql("i killed kennedy")
      end
    end

    describe "2nd hand methods" do
      it "teaches the method and preserves the student's instance variables" do
        teacher.teach(bob, jim, :say_name)
        teacher.teach(tom, bob, :say_name)
        expect(jim.say_name).to eql("my name is Jim")
        expect(bob.say_name).to eql("my name is Bob")
        expect(tom.say_name).to eql("my name is Tom")
      end

      it "preserves the student's private methods" do
        teacher.teach(bob, jim, :say_secret)
        teacher.teach(tom, bob, :say_secret)
        expect(bob.say_secret).to eql("i am elvis")
        expect(jim.say_secret).to eql("i killed kennedy")
        expect(tom.say_secret).to eql("i am a woman")
      end
    end
  end

  describe "edge cases" do
    it "allows teachers to be created" do
      teacher.teach(tom, teacher, :teach)
      tom.teach(bob, jim, :say_name)
      expect(bob.say_name).to eql("my name is Bob")
    end

    it "allows teacher to teach own 2nd hand teaching skills to others" do
      teacher.teach(tom, teacher, :teach)
      tom.teach(bob, tom, :teach)
      bob.teach(tom, jim, :say_name)
      expect(jim.say_name).to eql("my name is Jim")
    end
  end
end

#...private methods?