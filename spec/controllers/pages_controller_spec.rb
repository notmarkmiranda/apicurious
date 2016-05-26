require 'rails_helper'

describe PagesController do
  it "sends to a splash page" do
    get :splash
    expect(response).to render_template(:splash)
  end

  it "sends to a home page" do
    user = User.create(screen_name: "notmarkmiranda",
                       uid: "3300701839",
                       oauth_token: "3300701839-FYiAhJAUJ7espcn1Ivxnhya3ucplDrQ9A497t5Q",
                       oauth_token_secret: "N29oGaen6AnqEqZcmP4g8JAqtYN0Z39gcken1cDpAgvXe")
    expect(controller).current_user { user }
    get :home
    expect(response).to render_template(:home)
  end
end
