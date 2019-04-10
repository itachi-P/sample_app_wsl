class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      # 下記は redirect_to user_url(@user)と同じと解釈される
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # 以降の定義がprivateであることを明示する為にネストを一段深くする
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
