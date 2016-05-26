require 'rails_helper'

describe PagesController do
  it "sends to a splash page" do
    get :splash
    expect(response).to render_template(:splash)
  end

  it "sends to a home page" do
    VCR.use_cassette("home_timeline") do
      user = User.create(screen_name: "notmarkmiranda",
                         uid: "3300701839",
                         oauth_token: ENV["OAUTH_TOKEN"],
                         oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get :home
      expect(response).to render_template(:home)
    end
  end
end
