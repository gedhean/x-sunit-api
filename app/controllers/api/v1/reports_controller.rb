class Api::V1::ReportsController < ApplicationController
	# GET api/v1/reports
	def index
		@reports = Report.all
		render json: { results: @reports }, status: :ok		
	end	
end