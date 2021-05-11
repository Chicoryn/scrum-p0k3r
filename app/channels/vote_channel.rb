class VoteChannel < ApplicationCable::Channel
  def subscribed
    @room_hash = RoomHashService.from_hash(params[:id])
    @room = Room.find_by_id(@room_hash.room_id)
    @participant = Participant.find_by_id(@room_hash.participant_id)
    @participant.update_attribute(:connected, 1)

    stream_for @room
  end

  def unsubscribed
    @participant.update_attribute(:connected, 0)
    VoteChannel.broadcast_new_participant(@participant)
    stop_all_streams
  end

  def self.broadcast_new_vote(vote)
    VoteChannel.broadcast_to(vote.room, {
      reload: {
        current_standing: true
      }
    })
  end

  def self.broadcast_new_participant(participant)
    VoteChannel.broadcast_to(participant.room, {
      reload: {
        current_standing: true
      }
    })
  end

  def self.broadcast_new_round(round)
    VoteChannel.broadcast_to(round.room, {
      reload: true
    })
  end
end
