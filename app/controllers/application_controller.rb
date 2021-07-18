class ApplicationController < ActionController::API
  include Pagy::Backend
  include Response
  include ExceptionHandler
end
