class RoomHashService
  attr_accessor :room_id, :participant_id

  def initialize(room_id, participant_id)
    @participant_id = participant_id
    @room_id = room_id
  end

  def self.from_hash(hash_str)
    object = JSON.parse(Base64.urlsafe_decode64(hash_str))

    RoomHashService.new(
      object['room']&.to_i,
      object['participant']&.to_i
    )
  end

  def hash
    Base64.urlsafe_encode64({
      participant: @participant_id,
      room: @room_id
    }.to_json)
  end
end
