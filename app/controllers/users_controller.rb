class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      flash[:success] = 'Account Successfully Created!'
      session[:user_id] = new_user.id
      redirect_to user_dashboard_path(new_user.id)
    else
      flash[:error] = 'Unable to register, please try again.'
      redirect_to register_path
    end
  end

  def discover
    @user = User.find(params[:user_id])
  end

  private

    def user_params
      params.permit(:email, :name)
    end
end
