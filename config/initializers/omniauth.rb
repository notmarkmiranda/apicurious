Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, ENV["TWITTER_CONSUMER_API_KEY"], ENV["TWITTER_CONSUMER_API_SECRET"]
end
