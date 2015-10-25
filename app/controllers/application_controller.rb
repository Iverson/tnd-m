class ApplicationController < ActionController::Base
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :flash => {error: exception.message}
  end

  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end
