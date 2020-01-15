Rails.application.routes.draw do
	root :to => "locode#index"
	get "/autocomplete", to: 'locode#autocomplete'
end
