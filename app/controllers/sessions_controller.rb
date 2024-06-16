class SessionsController < ApplicationController

  before_action :loggedin_redirect, only: [:new, :create]
  def index

  end

  def new

  end
  def create
    user= User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in Successfully"
      redirect_to root_path
    else
      flash.now[:error] ="Invalid Credntials"
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil
    flash[:success] = "Sucessfully Logged out"
    redirect_to login_path
  end
  private
  def loggedin_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end


end