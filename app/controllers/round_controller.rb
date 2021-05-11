class RoundController < ApplicationController
  def create
    round = Round.create(
      room_id: params[:room_id],
      description: params[:description]
    )

    render json: { round_id: round.id }
  end
end
