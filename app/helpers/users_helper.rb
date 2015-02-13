module UsersHelper

  def correct_user_validation
	  unless params[:id] == current_user.id.to_s
      redirect_to login_url
    end
  end
  
end
