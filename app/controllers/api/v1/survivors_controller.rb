class Api::V1::SurvivorsController < ApplicationController
	before_action :set_survivor, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

	# List all Survivors
	# GET /survivors
	def index
		@survivors = Survivor.order('name ASC');
		render json: { success: true, results: @survivors }, status: :ok
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