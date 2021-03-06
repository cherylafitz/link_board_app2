class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:user][:email],params[:user][:password])
      @user = User.create user_params
    if user
      flash[:danger] = 'You already have an account. Please sign in.'
      redirect_to login_path
    # can't prevent people from creating nil accounts
    elsif @user.errors.any?
      flash[:danger] = @user.errors.full_messages.uniq.to_sentence
      render :new
    else
      user = User.authenticate(params[:user][:email],params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = 'You have created an account, and are now logged in.'
      redirect_to root_path
    end

    # @user_id = User.find params[:id]
  end




  private

  def user_params
    params.require(:user).permit(:email,:password,:name)
  end

end
