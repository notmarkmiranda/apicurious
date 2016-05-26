require 'rails_helper'

describe Tweet do
  before do
    @user = User.create(screen_name: "notmarkmiranda",
                       uid: "3300701839",
                       oauth_token: ENV["OAUTH_TOKEN"],
                       oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
  end

  it "retrieves tweets from home_timeline" do
    VCR.use_cassette("home_timeline") do
      tweets = Tweet.home_timeline(@user)
      tweet = tweets.first
      expect(tweets.count).to be > 40
      expect(tweet.user[:name]).to eq "Jeff Casimir"
      expect(tweet.user[:screen_name]).to eq "j3"
    end
  end

  it "retrieves tweets from user_timeline" do
    VCR.use_cassette("user_timeline") do
      tweets = Tweet.user_timeline(@user)
      tweet  = tweets.first
      expect(tweets.count).to be > 40
      expected_text = "After a few hours of frustration, we finally have stuff. #apicurious… https://t.co/NqPiPlfVRQ"
      expect(tweet.text).to eq expected_text
    end
  end

  it "retrieves followers for specific user" do
    VCR.use_cassette("followers") do
      followers = Tweet.followers(@user)
      follower = followers.first

      expect(follower[:name]).to eq "Ling Tran"
    end
  end

  it "knows who i am" do
    VCR.use_cassette("tweet#who_am_i") do
      me = Tweet.who_am_i(@user)
      expect(me.name).to eq "Mark Miranda"
      expect(me.screen_name).to eq "notmarkmiranda"
    end
  end

end
