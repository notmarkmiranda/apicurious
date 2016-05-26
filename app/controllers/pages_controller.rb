class PagesController < ApplicationController

  def splash
    redirect_to home_path if current_user
  end

  def home
    @tweets = TwitterService.new.home_timeline(current_user)
  end
end
