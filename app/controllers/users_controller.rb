class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # 上記は redirect_to user_url(@user)と同じと解釈される
    else
      render 'new'
    end
  end

  private
    # 以降privateであることを明示する為にネストを一段深くするのは有用
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end