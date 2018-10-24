class WelcomeController < ApplicationController
	def index
		render :index
		# render json: { welcome: "X-SUNIT API" }
	end
end