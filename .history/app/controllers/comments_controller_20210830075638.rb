class CommentsController < ApplicationController
  before_action :set_travel_record
  def create
    #投稿に紐づいたコメントを作成
    @comment = @travel_record.comments.new(comment_params)
    @comment.user = current_user

    # 返信コメントの作成
    @comment_reply = @travel_record.comments.new

    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
    else
      flash.now[:alert] ="コメントの投稿に失敗しました。"
    end
  end

  def destroy
    # 返信フォームに渡しているインスタンス変数（下記２行）
    @comment_reply = @travel_record.comments.new

    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:warning] = "コメントを削除しました。"
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :travel_record_id, :parent_id)
    end

    def set_travel_record
      @travel_record = TravelRecord.find(params[:travel_record_id])
    end
end
