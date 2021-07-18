require 'rails_helper'

# Test suite for the Score model
RSpec.describe Score, type: :model do
  # Association test
  # ensure an score record belongs to a single player record
  it { should belong_to(:player) }
end
