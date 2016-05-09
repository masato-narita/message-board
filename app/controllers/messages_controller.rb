class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]

# メッセージ一覧の表示  
  def index
    @message = Message.new
    # Messageを全て取得する。
    @messages = Message.all
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path , notice: 'メッセージを保存しました'
    else
      # メッセージが保存できなかった時
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end
  end

# メッセージの編集
  def edit
  end
  
  def update
    if @message.update(message_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      flash.now[:alert] = "メッセージの編集に失敗しました。"
      render 'edit'
    end
  end
  
# メッセージの削除
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end
  
# ストロングパラメータ
  private
  def message_params
    params.require(:message).permit(:name, :body, :age)
  end
  ## ここまで
  def set_message
    @message = Message.find(params[:id])
  end
end
