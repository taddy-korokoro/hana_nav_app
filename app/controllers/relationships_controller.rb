class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user, flash: { notice: "フォローしました" } }
      format.js
    end
    flash.now[:notice] = "フォローしました。"
  end

  def destroy
    @user = User.find(params[:relationship][:following_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, flash: { warning: "フォローを解除しました" } }
      format.js
    end
    flash.now[:warning] = "フォローを解除しました。"
  end
end