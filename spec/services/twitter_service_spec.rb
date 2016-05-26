require 'rails_helper'

describe TwitterService do
  it "returns tweets from home timeline" do
    VCR.use_cassette("home_timeline") do
      user = User.create(screen_name: "notmarkmiranda",
                         uid: "3300701839",
                         oauth_token: ENV["OAUTH_TOKEN"],
                         oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
      service = TwitterService.new
      tweets = service.home_timeline(user)
      tweet = tweets.first

      expect(tweets.count).to eq 50
      expect(tweet[:user][:name]).to eq "JetBlue Airways"
      expect(tweet[:user][:screen_name]).to eq "JetBlue"
      expect(tweet[:user][:id]).to eq 6449282
    end

  end
end
