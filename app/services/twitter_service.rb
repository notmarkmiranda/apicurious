require 'net/http'
require 'oauth'
require 'json'

class TwitterService

  # exchange oauth_token & oauth_token_secret for an AccessToken instance.
  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(ENV["TWITTER_CONSUMER_API_KEY"],
                                   ENV["TWITTER_CONSUMER_API_SECRET"],
                                   {site: "https://api.twitter.com", scheme: :header })
    # create access token from passed values
    token_hash = { oauth_token: oauth_token,
                   oauth_token_secret: oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    return access_token
  end

  # exchange our oath token & secret for AccessToken instance
  #  access_token = prepare_access_token(ENV["OAUTH_TOKEN"], ENV["OAUTH_TOKEN_SECRET"])

  # use the token as an agent to get the home timeline
  # response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
end
