class UsersController < ApplicationController

  def show
    if params[:id].to_i != 0
	@user =User.find_by_id params[:id] 
	#User.where(params[:id]).last 
    else
       @user = User.where(:name => params[:id]).last     
    end
  end

  def new
	  @user = User.new
  end      

  def create
    user = User.new(user_params)
    if user.save
	log_in user
 	    flash[:success] = "Congrats, you created your account!"
	    # Handle a successful save.
	  redirect_to user_url(user)
	  #redirect_back_or(@user)
    else
	    
    @title = "Sign up"
      render 'new'
    end
  end
    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
