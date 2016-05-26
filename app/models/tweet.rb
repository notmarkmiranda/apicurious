class Tweet < OpenStruct

  def self.home_timeline(user)
    TwitterService.new.home_timeline(user).map do |raw_tweet|
      Tweet.new(raw_tweet)
    end
  end

  def self.user_timeline(user)
    TwitterService.new.user_timeline(user).map do |raw_tweet|
      Tweet.new(raw_tweet)
    end
  end

  def self.followers(user)
    TwitterService.new.followers(user)[:users].each do |raw_follower|
      Tweet.new(raw_follower)
    end
  end

  def self.who_am_i(user)
    me = TwitterService.new.user_show(user)
    Tweet.new(me)
  end
end
