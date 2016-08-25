class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end
end
