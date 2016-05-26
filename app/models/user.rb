class User < ActiveRecord::Base

	def self.find_or_create_from_auth_hash(auth_hash)
		user = where(uid: auth_hash.uid).first_or_create
		user.update(oauth_token: 				auth_hash.credentials.token,
							  oauth_token_secret: auth_hash.credentials.secret)
		user
	end

end
