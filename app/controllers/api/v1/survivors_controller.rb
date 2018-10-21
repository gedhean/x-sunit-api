class Api::V1::SurvivorsController < ApplicationController
	before_action :set_survivor, only: [:show, :update, :destroy]

	# List all Survivors
	def index
		@survivors = Survivor.order('name ASC');
		render json: { success: true, results: @survivors }, status: :ok
	end

	# List survivor by id
	def show
		unless @survivor.nil?
			render json: { success: true, message: 'Survivor found', result: @survivor }, status: :ok
		else
			render json: { success: false, message: 'Survivor not found' }, status: :unprocessable_entity
		end
	end

	# Create a new survivor
	def create
		@survivor = Survivor.new(survivor_params)

		if @survivor.save
			render json: { success: true, message: 'Survivor created', result: @survivor }, status: :created
		else
			render json: { success: false, message: @survivor.errors, result: @survivor }, status: :unprocessable_entity
		end	
	end

	# Delete a survivor
	def destroy
		@survivor.destroy
		render json: { success: true, message: 'Survivor deleted', result: @survivor }, status: :ok

	end

	# Update a survivor
	def update
		if @survivor.update_attributes(survivor_params)
			render json: { success: true, message: 'Survivor updated', result: @survivor }, status: :accepted
		else
			render json: { success: false, message: @survivor.errors, result: @survivor }, status: :unprocessable_entity
		end

	end

	private
	def survivor_params
		params.permit(:name, :age, :gender, :latitude, :longitude)
	end

	private
	def set_survivor
		@survivor = Survivor.find(params[:id])
	end
end