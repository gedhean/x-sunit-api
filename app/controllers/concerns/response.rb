module Response
	# Render JSON response
	def json_response(object, status = :ok)
    	render json: object, status: status
  	end
end