class Api::V1::SurvivorsController < ApplicationController
	before_action :set_survivor, 		only: [:show, :update, :destroy]
	before_action :set_total_survivors,	only: [:stats, :index]

	# Get survivors statistics
	# GET /survivors-stats
	def stats
		if @total_survivors == 0
			json_response({ message: "There no survirvors :'(" }, :not_found) 
		else 
			abducted = Survivor.where(abducted: true).count
			non_abducted = @total_survivors - abducted
			abducted_rate = (abducted.to_f/@total_survivors).truncate(4) * 100
			json_response({ 
				success: true, 
				abducted: abducted_rate, 
				non_abducted: 100 - abducted_rate 
			}, :ok )
		end	
	end

	# List all Survivors
	# GET /survivors
	def index
		per_page = 10
		page = params[:page] || 1
		total_results = @total_survivors
		total_pages = (total_results.to_f/per_page).ceil 

		@survivors = Survivor.paginate(:page => page, :per_page => per_page).order('name ASC');
		json_response({ 
			success: true, 
			page: page, 
			per_page: per_page, 
			total_pages: total_pages, 
			total_results: total_results, 
			results: @survivors }, :ok)
	end

	# List survivor by id
	# GET /survivors/:id
	def show
		json_response({ success: true, message: 'Survivor found', result: @survivor }, :ok)
	end

	# Create a new survivor
	# POST /survivors
	def create
		@survivor = Survivor.new(survivor_params)
		@survivor.save!
		json_response({ success: true, message: 'Survivor created', result: @survivor }, :created)
	end

	# Delete a survivor by id
	# DELETE /survivors/:id
	def destroy
		@survivor.destroy
		json_response({ success: true, message: 'Survivor deleted', result: @survivor }, :accepted)
	end

	# Update a survivor by id
	# PUT /survivors/:id
	def update
		@survivor.update!(survivor_params)
		json_response({ success: true, message: 'Survivor updated', result: @survivor }, :accepted)
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
	# Get total number of survivors
	def set_total_survivors
		@total_survivors = Survivor.count
	end
end