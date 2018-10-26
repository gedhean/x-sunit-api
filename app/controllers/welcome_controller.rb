class WelcomeController < ApplicationController
	include ActionView::Rendering
	
	def index
		render :index
		# render json: { welcome: "X-SUNIT API" }
	end
end