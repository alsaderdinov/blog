class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

  private

  def handle_not_authorized
    flash[:danger] = 'You are not authorized to perform this action!'
    redirect_back(fallback_location: root_path)
  end
end
