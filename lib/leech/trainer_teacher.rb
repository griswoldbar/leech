require 'leech/trainer'

module Leech
  module TrainerTeacher
    def train(trainer, victim, method)
      register_trainer(trainer) unless trainer_registered?(trainer)
      trainer.victim_register[method] = victim
    end

    private
    def trainer_registered?(trainer)
      trainer.is_a?(Leech::Trainer)
    end

    def register_trainer(trainer)
      trainer.extend(Leech::Trainer)
    end
  end
end