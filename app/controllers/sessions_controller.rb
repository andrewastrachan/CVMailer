class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new]
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user # user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to jobs_path
    else
      flash.now[:danger] = "Invalid email/password confirmation"
      render 'new'
    end
  end
  
  def destroy
    log_out!
    redirect_to root_path
  end
end
