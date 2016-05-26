require 'rails_helper'

describe PagesController do

  before do
    @user = User.create(screen_name: "notmarkmiranda",
                        uid: "3300701839",
                        oauth_token: ENV["OAUTH_TOKEN"],
                        oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
  end

  it "sends to a splash page" do
    get :splash
    expect(response).to render_template(:splash)
  end

  it "sends to a home page" do
    VCR.use_cassette("home_timeline") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      get :home
      expect(response).to render_template(:home)
    end
  end

  it "sends to a user page" do
    VCR.use_cassette("user_timeline") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      get :profile
      expect(response).to render_template(:profile)
    end
  end

  it "sends to a followers page" do
    VCR.use_cassette("followers") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      get :followers
      expect(response).to render_template(:followers)
    end
  end
end
