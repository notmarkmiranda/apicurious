require 'rails_helper'

describe TwitterService do
  before do
    @user = User.create(screen_name: "notmarkmiranda",
                       uid: "3300701839",
                       oauth_token: ENV["OAUTH_TOKEN"],
                       oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
    @service = TwitterService.new
  end

  it "returns tweets from home timeline" do
    VCR.use_cassette("home_timeline") do
      tweets = @service.home_timeline(@user)
      tweet  = tweets.first

      expect(tweets.count).to be > 40
      expect(tweet[:user][:name]).to eq "Jeff Casimir"
      expect(tweet[:user][:screen_name]).to eq "j3"
      expect(tweet[:user][:id]).to eq 1133971
    end
  end

  it "returns tweeets from user timeline" do
    VCR.use_cassette("user_timeline") do
      tweets = @service.user_timeline(@user)
      tweet  = tweets.first
      expect(tweets.count).to be > 40
      expected_text = "After a few hours of frustration, we finally have stuff. #apicurious… https://t.co/NqPiPlfVRQ"
      expect(tweet[:text]).to eq expected_text
    end
  end

  it "returns followers for a specific user" do
    VCR.use_cassette("followers") do
      users = @service.followers(@user)
      user = users.first[1].first
      expect(users.count).to be > 1
      expect(user[:name]).to eq "Ling Tran"
    end
  end

  it "returns current users info" do
    VCR.use_cassette("user#show") do
      user = @service.user_show(@user)
      expect(user[:name]).to eq "Mark Miranda"
      expect(user[:location]).to eq "Denver, CO"
      expect(user[:screen_name]).to eq "notmarkmiranda"
    end
  end
end
