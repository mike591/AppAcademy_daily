require 'rails_helper'
# require 'spec_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe User do
    subject(:user) do
      user = User.new(username: "scott", password: "good_password")
      # FactoryGirl.build(:user,
      # username: "scott",
      # password: "good_password")
    end

    it { should have_many(:goals) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it "Should ensure session token" do
      expect(user.session_token).to_not be_nil
    end

    describe "#is_password?" do
      it "Should accept good password" do
        expect(user.is_password?("good_password")).to be true
      end

      it "Should reject bad password" do
        expect(user.is_password?("bad_password")).to be false
      end
    end

    it "Resets session token" do
      old_token = user.session_token
      expect(user.reset_session_token!).to_not eq(old_token)
    end

    describe "::find_by_credentials" do
      before { user.save! }

      it "Finds by valid credentials" do
        found_user = User.find_by_credentials("scott", "good_password")
        expect(found_user).to_not be_nil
      end

      it "Rejects by invalid credentials" do
        found_user = User.find_by_credentials("scott23", "good_password")
        expect(found_user).to be_nil
      end

    end



  end
end
