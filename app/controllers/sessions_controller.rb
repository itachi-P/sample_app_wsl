class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # ユーザーログイン処理後ユーザー情報ページにリダイレクト
      # flash[:success] = "ログインしたお"
      log_in @user
      # "Remember me"チェックボックスの値に従い永続化Cookieにユーザーを保存または破棄
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      # エラーメッセージを手動で作成しflashにセット
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # ユーザーがログイン状態の場合のみログアウト処理(複数タブ・複数ブラウザ対処)
    log_out if logged_in?
    redirect_to root_url
  end
end
