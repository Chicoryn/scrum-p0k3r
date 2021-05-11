class Participant < ApplicationRecord
  belongs_to :room
  has_many :votes

  scope :connected, -> { where(connected: true) }
  scope :voted, -> (round_id) { where(id: Vote.where(round_id: round_id).select(:participant_id)) }

  after_create :broadcast_new_participant
  after_update :broadcast_new_participant

  def choice_for_round(round_id)
    vote = votes.for_round(round_id).take
    vote&.choice&.[]('value')
  end

  private

  def broadcast_new_participant
    VoteChannel.broadcast_new_participant(self)
  end
end
