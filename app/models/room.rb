class Room < ApplicationRecord
  has_many :rounds

  after_create :ensure_round

  def current_round
    self.rounds.latest
  end
end
