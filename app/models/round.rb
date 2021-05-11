class Round < ApplicationRecord
  belongs_to :room

  def self.latest
    order(:created_at).last
  end
end
