class AddRoomIdToRound < ActiveRecord::Migration[6.1]
  def change
    add_column :rounds, :room_id, :int
  end
end
