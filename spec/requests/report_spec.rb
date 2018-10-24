require 'rails_helper'

RSpec.describe 'Reports API', type: :request do
	# Initial data
	let!(:survivors){ create_list(:survivor, 15)}
	let!(:reports)	{ create_list(:report, 7) }

	describe 'GET /reports' do
		before { get '/api/v1/reports' }
		it 'returns reports in JSON format' do
			expect(json).not_to be_empty
			expect(json).to have_key("results")
			expect(json["results"]).not_to be_empty
		end
		it 'responde with status code 200 OK' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'POST /reports' do
		let(:valid_params) { { 
			reporter_id: survivors.sample.id, 
			abducted_id: survivors.sample.id, 
			message: 'Fulanin was abducted!' 
		} }
		context 'when request is valid' do
			before { post '/api/v1/reports', params: valid_params }
			it 'create a report' do
				expect(json["message"]).to eq("Report created")
			end
			it 'responde with status code 201 Created' do
				expect(response).to have_http_status(201)
			end
		end
		context 'when request parameters are invalid' do
			before { post '/api/v1/reports', params: { reporter_id: 1, abducted_id: "wot"} }
			it 'returns error message' do
				expect(json).to have_key("errors")
				expect(json["errors"]).not_to be_empty
			end
			it 'responde with status code 422 Unprocessable Entity' do
				expect(response).to have_http_status(422)
			end
		end
		context 'when abducted_id does not exist in Survivors' do
			before { post '/api/v1/reports', params: { reporter_id: 5, abducted_id: 666, message: "I not exist!" } }
			it 'returns error message' do
				expect(json).to have_key("errors")
				expect(json["errors"]).not_to be_empty
			end
			it 'responde with status code 404 NotFound' do
				expect(response).to have_http_status(404)
			end
		end
	end
end