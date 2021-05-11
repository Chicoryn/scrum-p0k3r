class RoomController < ApplicationController
  before_action :set_room, only: [:show, :current_standing]
  before_action :set_connected, only: [:show]

  def create
    room = Room.create(
      name: params[:name]
    )

    redirect_to (
      new_room_participant_path(
        RoomHashService.new(room.id, nil).hash
      )
    )
  end

  def join
    redirect_to new_room_participant_path(params[:id])
  end

  def show
    # pass
  end

  def current_standing
    render partial: 'current_standing', locals: { room: @room, participant: @participant, round: @round }, layout: false
  end

  private

  def set_room
    @room_hash = RoomHashService.from_hash(params[:id])
    @room = Room.find_by_id(@room_hash.room_id)
    @round = @room.current_round
    @participant = Participant.find_by_id(@room_hash.participant_id)
  end

  def set_connected
    @participant.update_attribute(:connected, 1)
  end
end
