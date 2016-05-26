require 'rails_helper'
require 'ostruct'

describe User do
  it "can create a new user" do
    cred = { token:  "3300701839-FYiAhJAUJ7espcn1Ivxnhya3ucplDrQ9A497t5Q",
             secret: "N29oGaen6AnqEqZcmP4g8JAqtYN0Z39gcken1cDpAgvXe"}
    credentials = OpenStruct.new(cred)
    ah   = { screen_name: "notmarkmiranda",
             uid:         "3300701839",
             credentials: credentials }
    auth_hash = OpenStruct.new(ah)
    expect(User.all.size).to eq 0
    user = User.find_or_create_from_auth_hash(auth_hash)
    expect(User.all.size).to eq 1
  end

  it "can find an existing user" do
    cred = { token:  "3300701839-FYiAhJAUJ7espcn1Ivxnhya3ucplDrQ9A497t5Q",
             secret: "N29oGaen6AnqEqZcmP4g8JAqtYN0Z39gcken1cDpAgvXe"}
    credentials = OpenStruct.new(cred)
    ah   = { screen_name: "notmarkmiranda",
             uid:         "3300701839",
             credentials: credentials }
    auth_hash = OpenStruct.new(ah)
    user = User.find_or_create_from_auth_hash(auth_hash)
    expect(User.all.size).to eq 1
    user = User.find_or_create_from_auth_hash(auth_hash)
    expect(User.all.size).to eq 1
  end
end
