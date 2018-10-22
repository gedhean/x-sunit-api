class Api::V1::SurvivorsController < ApplicationController
	before_action :set_survivor, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

	# List all Survivors
	def index
		@survivors = Survivor.order('name ASC');
		render json: { success: true, results: @survivors }, status: :ok
	end

	# List survivor by id
	def show
		render json: { success: true, message: 'Survivor found', result: @survivor }, status: :ok
	end

	# Create a new survivor
	def create
		@survivor = Survivor.new(survivor_params)
		@survivor.save!
		render json: { success: true, message: 'Survivor created', result: @survivor }, status: :created
	end

	# Delete a survivor
	def destroy
		@survivor.destroy
		render json: { success: true, message: 'Survivor deleted', result: @survivor }, status: :accepted
	end

	# Update a survivor
	def update
		@survivor.update!(survivor_params)
		render json: { success: true, message: 'Survivor updated', result: @survivor }, status: :accepted
	end

	private
	def survivor_params
		params.permit(:name, :age, :gender, :latitude, :longitude)
	end

	def set_survivor
		@survivor = Survivor.find(params[:id])
	end

	def render_unprocessable_entity_response(exception)
		render json: { success: false, errors: exception.record.errors }, status: :unprocessable_entity
	end

	def render_not_found_response(exception)
		render json: { success: false, errors: exception.message }, status: :not_found
	end
end