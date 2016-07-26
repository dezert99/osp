class UsersController < Devise::RegistrationsController
  def sign_out
  	super
  	redirect_to new_users_session_path
  end
end