class ParticipantController < ApplicationController
  before_action :set_room

  def new
    # pass
  end

  def create
    participant = Participant.create(
      room_id: @room.id,
      name: params[:name]
    )

    redirect_to(
      room_path(
        RoomHashService.new(@room.id, participant.id).hash
      )
    )
  end

  private

  def set_room
    @room_hash = RoomHashService.from_hash(params[:room_id])
    @room = Room.find_by_id(@room_hash.room_id)
  end
end
