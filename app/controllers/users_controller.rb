class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:user][:email],params[:user][:password])
    if user
      flash[:danger] = 'You already have an account. Please sign in.'
      redirect_to login_path

    # can't prevent people from creating nil accounts
    elsif user_params
      @user = User.create user_params
      user = User.authenticate(params[:user][:email],params[:user][:password])
      session[:user_id] = @user.id
      # session[:email] = @user.email
      # session[:password_digest] = @user.password_digest
      flash[:success] = 'You have created an account, and are now logged in.'
    #   flash[:danger] = 'Please enter an email and password.'
    #   redirect_to signup_path
    else
      flash[:danger] = 'Invalid username or password.'
      redirect_to signup_path
    end
      redirect_to root_path

    # @user_id = User.find params[:id]
  end




  private

  def user_params
    params.require(:user).permit(:email,:password,:name)
  end

end
