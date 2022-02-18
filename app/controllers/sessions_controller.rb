class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.name}. Let's party... lite"
      redirect_to "/users/#{user.id}"
    else
      flash[:alert] = "Error"
      render :login
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end