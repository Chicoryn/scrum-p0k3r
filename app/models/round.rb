class Round < ApplicationRecord
  belongs_to :room
  has_many :votes

  after_create :broadcast_new_round

  def self.latest
    order(:created_at).last
  end

  private

  def broadcast_new_round
    VoteChannel.broadcast_new_round(self)
  end
end
