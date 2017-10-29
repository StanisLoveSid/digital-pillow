class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper
  include CanCan::ControllerAdditions
  helper_method :current_order
  helper_method :number_to_grn
  #protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_path
  end

  def current_order
    if !session[:order_id].nil?
      !find_order.in_progress? && !find_order.filled? ? Order.new(number: number_generator, delivery: find_delivery) : find_order
    else
      Order.new(number: number_generator, delivery: find_delivery)
    end
  end

  def number_to_grn(number)
    number_to_currency(number, unit: "грн", format: "%n %u")
  end

  def number_generator
    "#N"+Time.now.to_f.to_s[0, 10]
  end

  def find_delivery
    Delivery.find_by(name: "none")
  end

  def find_order
    Order.find(session[:order_id])
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:first_name, :email, :password, :current_password)
    end
  end

end
