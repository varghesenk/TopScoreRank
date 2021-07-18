class Score < ApplicationRecord
  belongs_to :player
  scope :created_before, ->(time) { where('created_at < ?', time.to_datetime) }
  scope :created_after, ->(time) { where('created_at > ?', time.to_datetime+1.day) }
  scope :of_players, ->(names) {
    joins(:player).merge(Player.of_names(names))
  }

  # Some last mile check
  validates :created_at, presence:  true
  #validates :created_at, presence: true, timeliness: {type: :datetime}
  validates :score, numericality: { greater_than:0 }
end
