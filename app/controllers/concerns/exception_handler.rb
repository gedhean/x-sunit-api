module ExceptionHandler
	# provides the more graceful `included` method
 	extend ActiveSupport::Concern

 	included do
 		rescue_from ActiveRecord::RecordNotFound do |e|
 			json_response({ success: false, errors: e.message }, :not_found)
 		end

 		rescue_from ActiveRecord::RecordInvalid do |e|
 			json_response({ success: false, errors: e.record.errors }, :unprocessable_entity)
 		end
 	end
end