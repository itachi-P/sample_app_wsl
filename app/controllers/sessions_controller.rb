class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン処理後ユーザー情報ページにリダイレクト
      # flash[:success] = "ログインしたお"
      log_in user
      # 永続化Cookieにユーザーを保存
      remember user
      redirect_to user
    else
      # エラーメッセージを手動で作成しflashにセット
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
