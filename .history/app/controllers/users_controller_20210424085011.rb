class UsersController < ApplicationController
  def show
    # @user = current_user
    @users = User.find(params[:id])
  end
end
