class CommentsController < ApplicationController
  def create
    @travel_record = TravelRecord.find(params[:travel_record_id])
    #投稿に紐づいたコメントを作成
    @comment = @travel_record.comments.new(comment_params)
    @comment.user_id = current_user.id
    # 返信コメントの作成
    @comment_reply = @travel_record.comments.new
    # _hide_commentsの返信フォームの第２引数を@travel_record.comments.buildに変更すれば
    # renderのローカル変数を記述しなくても正常に動作する（検証要）
    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
      render :index
    else
      flash.now[:alert] ="コメントの投稿に失敗しました。"
      render :index
    end
  end

  def destroy
    # 返信フォームに渡しているインスタンス変数（下記２行）
    # @travel_record = TravelRecord.find(params[:travel_record_id])
    @comment_reply = Comment.new

    # @comment = @travel_record.comments
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = "コメントを削除しました。"
    render :index
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :travel_record_id, :parent_id)
    end
end
