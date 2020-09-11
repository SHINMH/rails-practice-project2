class UserItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_items = current_user.user_items.page(params[:page]).per(10)
  end

end
