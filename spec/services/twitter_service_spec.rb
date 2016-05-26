require 'rails_helper'

describe TwitterService do
  it "returns tweets from home timeline" do
    VCR.use_cassette("home_timeline") do
      user = User.create(screen_name: "notmarkmiranda",
                         uid: "3300701839",
                         oauth_token: "3300701839-FYiAhJAUJ7espcn1Ivxnhya3ucplDrQ9A497t5Q",
                         oauth_token_secret: "N29oGaen6AnqEqZcmP4g8JAqtYN0Z39gcken1cDpAgvXe")
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
