class RoomController < ApplicationController
  def create
    @room = Room.create(
      name: params[:name]
    )

    redirect_to room_path(@room.id)
  end

  def index
    redirect_to room_path(params[:id]) if params[:id].present?
  end

  def show
    @room = Room.find_by(params[:id])
  end
end
