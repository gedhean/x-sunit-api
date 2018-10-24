Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
	namespace 'v1' do
	  		get '/survivors/stats', to: 'survivors#stats', as: 'statistics'
	  		resources :survivors, :reports
	  	end  	
  end
end
