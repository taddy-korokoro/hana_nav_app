require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe "バリデーション" do
    it "emailに正しい値が設定されている状態" do
      expect(@user).to be_valid
    end
    it "nameが空だとNG" do
      @user.name = ""
      expect(@user.valid?).to eq(false)
    end
  end
end