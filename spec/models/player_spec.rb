require 'rails_helper'

# Test suite for the Player model
RSpec.describe Player, type: :model do
  # Association test
  # ensure Player model has a 1:m relationship with the Score model
  it { should have_many(:scores).dependent(:destroy) }
  # Validation tests
  # ensure columns name and created_at are present before saving
  it { should validate_presence_of(:name) }
 # it { should validate_presence_of(:created_at) }
end
