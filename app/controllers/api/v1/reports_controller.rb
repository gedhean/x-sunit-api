class Api::V1::ReportsController < ApplicationController
	# GET api/v1/reports
	def index
		per_page = 20
		page = params[:page] || 1
		total_results = Report.count
		total_pages = (total_results.to_f/per_page).ceil

		@reports = Report.paginate(:page => page, :per_page => per_page).order('created_at ASC')
		render json: { 
				success: true,
				page: page,
				per_page: per_page,
				total_pages: total_pages,
				total_results: total_results,
				results: @reports
			}, status: :ok		
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