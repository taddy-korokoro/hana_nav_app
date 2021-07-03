class CommentsController < ApplicationController
  def create
    @travel_record = TravelRecord.find(params[:travel_record_id])
    #投稿に紐づいたコメントを作成
    @comment = @travel_record.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    # 返信コメントの作成
    @comment_reply = @travel_record.comments.comment.new
    # _hide_commentsの返信フォームの第２引数を@travel_record.comments.buildに変更すれば
    # renderのローカル変数を記述しなくても正常に動作する（検証要）
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :travel_record_id, :parent_id)
    end
end
