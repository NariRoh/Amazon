class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user&.authenticate params[:password]
      session[:user_id] = user.id
      if user.is_admin?
        redirect_to admin_panel_index_path
      else
        redirect_to root_path, notice: 'Signed in!'
      end
    else
      flash.now[:alert] = 'Wrong credentials'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

end
