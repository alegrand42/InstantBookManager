Rails.application.routes.draw do

	resources :uploads, only: [:index, :create, :destroy, :search, :show] do 
		collection do
			get :list #list_uploads_url
		end
	end

	get 'pages/home'
	get 'pages/help'
	root 'pages#home'

	get '/library', to: 'uploads#search'

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
