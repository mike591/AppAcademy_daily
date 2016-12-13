require 'rails_helper'

RSpec.describe Goal, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "associations" do
    it { should belong_to(:user) }
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:visibility) }
  it { should validate_presence_of(:finished) }
  it { should validate_presence_of(:cheers) }
  it { should validate_presence_of(:completed) }
end
