require 'spec_helper'
require 'leech/trainer_teacher'

describe Leech::TrainerTeacher do
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

  let(:trainer) { Leech::Actor.new("Mr Smith").tap {|t| t.extend(Leech::TrainerTeacher)} }
  let(:jim)     { Speaker.new("Jim") }

  describe "#train" do
    describe "instance methods" do
      let(:klass) { Class.new(Leech::Actor)  }

      it "gives instances of the class the taught method" do
        trainer.train(klass, jim, :say_name)
        expect(klass.new("Mike").say_name).to eql "my name is Mike"
      end
    end
  end
end