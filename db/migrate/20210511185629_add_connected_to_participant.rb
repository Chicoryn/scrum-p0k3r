class AddConnectedToParticipant < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :connected, :boolean
  end
end
