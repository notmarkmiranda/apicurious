require 'rails_helper'
require 'ostruct'

describe User do
  before do
    cred = { token:  ENV["OAUTH_TOKEN"],
             secret: ENV["OAUTH_TOKEN_SECRET"]}
    credentials = OpenStruct.new(cred)
    ah   = { screen_name: "notmarkmiranda",
             uid:         "3300701839",
             credentials: credentials }
    @auth_hash = OpenStruct.new(ah)
  end

  it "can create a new user" do
    expect(User.all.size).to eq 0
    user = User.find_or_create_from_auth_hash(@auth_hash)
    expect(User.all.size).to eq 1
  end

  it "can find an existing user" do
    user = User.find_or_create_from_auth_hash(@auth_hash)
    expect(User.all.size).to eq 1
    user = User.find_or_create_from_auth_hash(@auth_hash)
    expect(User.all.size).to eq 1
  end
end
