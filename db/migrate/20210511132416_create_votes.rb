class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :participant_id
      t.integer :round_id
      t.json :choice

      t.timestamps
    end
  end
end
