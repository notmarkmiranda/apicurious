require 'rails_helper'

describe SessionsController do


  it "creates or finds a user from auth hash" do
    post :create
    expect(response).to redirect_to root_path
  end

  it "creates or finds user from auth hash and redirects to home" do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      post :create
      expect(response).to redirect_to home_path
      expect(session[:user_id]).to_not be_nil
  end

  describe "#destroy" do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      post :create
    end

    it "destroys a session" do
      expect(session[:user_id]).to_not be_nil
      get :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end
  end


end
