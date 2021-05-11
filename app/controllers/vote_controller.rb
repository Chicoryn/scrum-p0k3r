class VoteController < ApplicationController
  before_action :set_room
  before_action :set_round

  def create
    vote =
      Vote.transaction do
        vote = Vote.find_or_create_by(
          participant_id: @participant.id,
          round_id: @round.id
        )
        vote.update_attribute(:choice, { value: params[:choice] })
        vote
      end

    render json: { vote_id: vote.id }
  end

  private

  def set_room
    @room_hash = RoomHashService.from_hash(params[:room_id])
    @room = Room.find_by_id(@room_hash.room_id)
    @participant = Participant.find_by_id(@room_hash.participant_id)
  end

  def set_round
    @round = Round.find_by_id(params[:round_id])
  end
end
