require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe "バリデーション" do
    it "nameとemailに正しい値が設定されている状態" do
      expect(@user.valid?).to eq(true)
    end
    it "nameが空だとNG" do
      expect(@user.name.valid?).to eq(false)
    end
  end
end