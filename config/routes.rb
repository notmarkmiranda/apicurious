Rails.application.routes.draw do
	root 'pages#splash'
	get '/auth/twitter', as: 'twitter_login'
	get '/auth/twitter/callback', to: 'sessions#create'
end
