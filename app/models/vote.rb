class Vote < ApplicationRecord
  belongs_to :participant
  belongs_to :round
  has_one :room, through: :round

  scope :for_round, -> (round_id) { where(round_id: round_id) }

  after_create :broadcast_new_vote
  after_update :broadcast_new_vote

  private

  def broadcast_new_vote
    VoteChannel.broadcast_new_vote(self)
  end
end
