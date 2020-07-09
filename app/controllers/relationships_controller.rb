class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def new
  end

  def follower
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followed
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  def create
    @user = User.find(params[:user_id])
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end



  private

    def relationship_params
      params.require(:relationship).permit(:user_id, :follow_id)
    end


end