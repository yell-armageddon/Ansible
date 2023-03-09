class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
	log_in user
#	redirect_back_or(@user)
	redirect_to(user)
      	    # Log the user in and redirect to the user's show page.
    else
      # Create an error message.
	flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
	render 'new'
    end
  end


  def destroy
    #User.find(session[:user_id]).destroy      
    session[:user_id] = nil         
    redirect_to '/' 
  end  

end
