class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

  private

  def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :email,
      profile_attributes: [
        :id, :user_id, :firstName, :lastName, :phoneNumber, :accountType, :businessName, :businessAddress, :businessRegNumber, :csPhoneNumber, :businessTaxRegNumber
      ])
  end

  def client_params
  	params.require(:client).permit(:user_id, :clientId, :contactPerson, :companyName, :companyAddress, :email, :phone)
  end

  def quotation_params
  	params.require(:quotation).permit(:user_id, :recipientId, :quoteId, :validUntil, :status, :subTotal, :taxRate, :tax, :total, :note, items_attributes: [:id, :itemable_type, :itemable_id, :description, :quantity, :unitPrice, :totalPrice, :_destroy])
  end
end
