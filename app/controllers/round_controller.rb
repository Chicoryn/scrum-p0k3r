class RoundController < ApplicationController
  before_action :set_room, only: [:create, :reset, :unseal]
  before_action :set_round, only: [:reset, :unseal]

  def create
    round = Round.create(
      room_id: @room.id,
      description: params[:description]
    )

    render json: { round_id: round.id }
  end

  def reset
    round = Round.create(
      room_id: @round.room_id,
      description: @round.description
    )

    render json: { round_id: round.id }
  end

  def unseal
    @round.votes.each do |vote|
      vote.update_attribute(:sealed, false)
    end

    render json: {}
  end

  private

  def set_room
    @room_hash = RoomHashService.from_hash(params[:room_id])
    @room = Room.find_by_id(@room_hash.room_id)
    @participant = Participant.find_by_id(@room_hash.participant_id)
  end

  def set_round
    @round = Round.find_by_id(params[:id])
  end
end
