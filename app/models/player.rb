class Player < ApplicationRecord
    has_many :scores, -> { order(created_at: :desc) }, dependent: :destroy
    scope :of_names, ->(names) { where(name: names) }
    #  -> { order(created_at: :desc) }

    validates_length_of :name, allow_blank: false
    validates_presence_of :name
end
