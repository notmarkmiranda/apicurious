Rails.application.routes.draw do
	root 'pages#splash'
	get '/auth/twitter', as: 'twitter_login'
	get '/auth/twitter/callback', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy', as: 'logout'
end
