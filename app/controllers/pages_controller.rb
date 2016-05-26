class PagesController < ApplicationController

  def splash
    redirect_to home_path if current_user
  end

  def home
    @tweets = Tweet.home_timeline(current_user)
  end

  def profile
    @user = Tweet.who_am_i(current_user)
    @tweets = Tweet.user_timeline(current_user)
  end

  def followers
    @user = Tweet.who_am_i(current_user)
    @followers = Tweet.followers(current_user)
  end
end
