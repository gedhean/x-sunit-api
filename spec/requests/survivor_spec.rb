require "rails_helper"

RSpec.describe "Survivors API", type: :request do
	# Initialize test data
	let!(:survivors) { create_list(:survivor, 20) }
	let(:survivor_id) { survivors.first.id }

	# Tests for GET /survivors
	describe "GET /survivors" do
		# make HTTP get request before each example
		before { get "/api/v1/survivors" }

		it "returns survivors in JSON format" do
			expect(json).not_to be_empty
			#expect(json.size).to eq(6)
		end

		it "returns status code 200 OK" do
			expect(response).to have_http_status(200)
		end
	end

	# Tests for GET survivors/:id
	describe "GET /survivors/:id" do
		context "when survivor exist" do
			before { get "/api/v1/survivors/#{survivor_id}" }
			
			it "returns the survivor" do
				expect(json).not_to be_empty
				expect(json["result"]["id"]).to eq(survivor_id)
			end

			it "returns status code 200 OK" do
				expect(response).to have_http_status(200)
			end
		end

		context "when survivor does not exist" do
			before { get "/api/v1/survivors/999999" }

			it "returns status code 404 NotFound" do
				expect(response).to have_http_status(404)
			end

			it "returns error mensages" do
				expect(json["errors"]).not_to be_empty
			end
		end
	end

	# Tests for POST /survivors
	describe "POST /survivors" do
		let(:valid_params) { 
			{ name: "Jedi Master King II", age: 23, gender: "Male", latitude: 23.1231, longitude: -23.321 } 
		}
		
		context "when the request is valid" do
			before { post "/api/v1/survivors", params: valid_params }

			it "create a survivor" do
				expect(json["result"]["name"]).to eq("Jedi Master King II")
			end

			it "returns status code 201 Created" do
				expect(response).to have_http_status(201)
			end
		end

		context "when request is invalid" do
			before { post "/api/v1/survivors", params: { name: "Noa", age: "Two" } }

			it "returns status code 422 Unprocessable Entity" do
				expect(response).to have_http_status(422)
			end

			it "returns error mensages" do
				expect(json["errors"]).not_to be_empty
			end
		end
	end

	# Tests for PUT /survivors/:id
	describe "PUT /survivors/:id" do
		let(:valid_params) { { name: "God Jedi Son Goku", age: 1000 } }
		
		context "when the survivor exist" do
			before { put "/api/v1/survivors/#{survivor_id}", params: valid_params }

			it "update the survivor" do
				expect(json["message"]).to eq("Survivor updated")
			end

			it "returns status code 202 Accepted" do
				expect(response).to have_http_status(202)
			end
		end

		context "when survivor not exist" do
			before { put "/api/v1/survivors/999999", params: valid_params }
			
			it "returns error message" do
				expect(json["errors"]).not_to be_empty
			end

			it "returns status code 404 NotFound" do
				expect(response).to have_http_status(404)
			end
		end
	end

	# Tests for DELETE /survivors/:id
	describe "DELETE /survivors/:id" do
		context "when survivor exist" do
			before { delete "/api/v1/survivors/#{survivor_id}" }

			it "returns status code 202 Accepted" do
				expect(response).to have_http_status(202)
			end

			it "returns success message" do
				expect(json["message"]).to eq("Survivor deleted")
			end
		end

		context "when survivor not exist" do
			before { delete "/api/v1/survivors/999999" }
			
			it "returns error message" do
				expect(json["errors"]).not_to be_empty
			end

			it "returns status code 404 NotFound" do
				expect(response).to have_http_status(404)
			end
		end
	end
end