module Api
	module V1
		class SurvivorsController < ApplicationController
			# List all Survivors
			def index
				survivors = Survivor.order('name');
				render json: { status: 'success', data: survivors }, status: :ok
			end

			# List survivor by id
			def show
				survivor = Survivor.find(params[:id])
				if survivor
					render json: { status: 'success', message: 'survivor found', data: survivor }, status: :ok
				else
					render json: { status: 'error', message: 'survivor not found' }, status: :unprocessable_entity
				end
			end

			# Create a new survivor
			def create
				survivor = Survivor.new(user_params)

				if survivor.save
					render json: { status: 'success', message: 'survivor created', data: survivor }, status: :ok
				else
					render json: { status: 'error', message: 'survivor not created!', data: survivor }, status: :unprocessable_entity
				end	
			end

			# Delete an survivor
			def destroy
				survivor = Survivor.find(params[:id])
				survivor.destroy
				render json: { status: 'success', message: 'survivor deleted', data: survivor }, status: :ok

			end

			# Update an survivor
			def update
				survivor = Survivor.find(params[:id])
				if survivor.update_attributes(user_params)
					render json: { status: 'success', message: 'survivor updated', data: survivor }, status: :ok
				else
					render json: { status: 'error', message: 'survivor not updated', data: survivor }, status: :unprocessable_entity
				end

			end

			private
			def user_params
				params.permit(:name, :age, :gender, :latitude, :longitude)
			end
		end
	end
end