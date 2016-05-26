class TwitterService

  def home_timeline(user)
    parse(access_token(user).request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=50"))
  end

  def user_timeline(user)
    parse(access_token(user).request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=50"))
  end

  def followers(user)
    parse(access_token(user).request(:get, "https://api.twitter.com/1.1/followers/list.json"))
  end

  def user_show(user)
    parse(access_token(user).request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=#{user.screen_name}"))
  end
  
  private

    def prepare_access_token(oauth_token, oauth_token_secret)
      consumer     = OAuth::Consumer.new(ENV["TWITTER_CONSUMER_API_KEY"],
                                         ENV["TWITTER_CONSUMER_API_SECRET"],
                                         { site: "https://api.twitter.com" })
      token_hash   = { oauth_token: oauth_token,
                       oauth_token_secret: oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
      return access_token
    end

    def access_token(user)
      prepare_access_token(user.oauth_token, user.oauth_token_secret)
    end

    def parse(input)
      JSON.parse(input.body, symbolize_names: true)
    end

end
