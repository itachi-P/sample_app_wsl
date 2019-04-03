class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報ページにリダイレクトする
      # flash[:success] = "ログインしたお"
      log_in user
      redirect_to user
    else
      # エラーメッセージを手動で作成しflashにセット
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
