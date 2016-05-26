class SessionsController < ApplicationController
	def create
		if @user = User.find_or_create_from_auth_hash(auth_hash)
			session[:user_id] = @user.id
			redirect_to home_path
		else
			redirect_to root_path
		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to root_path
	end

	private
		def auth_hash
			request.env['omniauth.auth']
		end
end
