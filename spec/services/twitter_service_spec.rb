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
      expect(tweet[:user][:name]).to eq "Universal Mind"
      expect(tweet[:user][:screen_name]).to eq "universalmind"
      expect(tweet[:user][:id]).to eq 14675801
    end
  end

  it "returns tweeets from user timeline" do
    VCR.use_cassette("user_timeline") do
      tweets = @service.user_timeline(@user)
      tweet  = tweets.first
      expect(tweets.count).to be > 40
      expected_text = "refreshing cassettes has allowed @j3 to invade my twitter_service_spec file. #turingschool #twitterapi https://t.co/LpdQdM10DU"
      expect(tweet[:text]).to eq expected_text
    end
  end

  it "returns followers for a specific user" do
    VCR.use_cassette("followers") do
      users = @service.followers(@user)
      user = users.first[1].first
      expect(users.count).to be > 1
      expect(user[:name]).to eq "Ana Freeman"
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
