class UsersController < ApplicationController
  before_action :correct_user_validation, only: [:show]
  before_action :redirect_if_logged_in, only: [:new]
  include UsersHelper
  
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    if params[:id] == current_user.id.to_s
      @user = User.find(params[:id])
      render :show
    else
      redirect_to new_session_url
    end
  end
  
  protected
  
    def user_params
      params.require(:user).permit(:email, :signature, :password, :password_confirmation)
    end
end
