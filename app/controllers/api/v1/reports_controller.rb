class Api::V1::ReportsController < ApplicationController
	# GET api/v1/reports
	def index
		@reports = Report.all
		render json: { results: @reports }, status: :ok		
	end	
	# POST api/v1/reports
	def create
		@report = Report.new(report_params)
		if @report.save
			render json: { success: true, message: "Report created", report: @report }, status: :ok
		else
			render json: { success: false, message: "Failed to create report"}, status: :unprocessable_entity
		end
	end

	private
	def report_params
		params.permit(:reporter_id, :abducted_id, :message)
	end
end