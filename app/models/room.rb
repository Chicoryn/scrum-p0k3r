class Room < ApplicationRecord
  has_many :rounds
  has_many :participants

  def current_round
    self.rounds.latest
  end
end
