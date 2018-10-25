class ApplicationController < ActionController::API
	include Response
	include ExceptionHandler
	include ActionView::Rendering
end
