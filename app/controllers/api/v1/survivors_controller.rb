class Api::V1::SurvivorsController < ApplicationController
	before_action :set_survivor, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

	# List all Survivors
	# GET /survivors
	def index
		per_page_param = params[:per_page].to_i.abs 
		page_param = params[:page].to_i.abs 
		per_page = per_page_param.zero? ? 10 : per_page_param 
		page =  page_param.zero? ? 1 : page_param 
		total_results = Survivor.count
		total_pages = (total_results.to_f / per_page).ceil 

		@survivors = Survivor.order('name ASC').offset(per_page * (page-1)).limit(per_page);
		render json: { success: true, page: page, per_page: per_page, total_pages: total_pages, total_results: total_results , results: @survivors }, status: :ok
		#per_page = params[:per_page]
		#paginate Survivor.order('name ASC'), per_page: 5
	end

	# List survivor by id
	# GET /survivors/:id
	def show
		render_json_response('Survivor found')
	end

	# Create a new survivor
	# POST /survivors
	def create
		@survivor = Survivor.new(survivor_params)
		@survivor.save!
		render_json_response('Survivor created', :created)
	end

	# Delete a survivor by id
	# DELETE /survivors/:id
	def destroy
		@survivor.destroy
		render_json_response('Survivor deleted', :accepted)
	end

	# Update a survivor by id
	# PUT /survivors/:id
	def update
		@survivor.update!(survivor_params)
		render_json_response('Survivor updated', :accepted)
	end

	private
	# Get survirvors parameters to create and update
	def survivor_params
		params.permit(:name, :age, :gender, :latitude, :longitude)
	end
	# Find survivor by id and set in @survivor 
	def set_survivor
		@survivor = Survivor.find(params[:id])
	end
	# Render JSON for success responses
	def render_json_response(message, status = :ok)
		render json: { success: true, message: message, result: @survivor }, status: status
	end
	# Handle Validation Failure
	def render_unprocessable_entity_response(exception)
		render json: { success: false, errors: exception.record.errors }, status: :unprocessable_entity
	end
	# Handle Not Found survivor 
	def render_not_found_response(exception)
		render json: { success: false, errors: exception.message }, status: :not_found
	end
end