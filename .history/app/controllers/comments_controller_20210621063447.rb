class CommentsController < ApplicationController
  def create
    @travel_record = TravelRecord.find(params[:travel_record_id])
    #投稿に紐づいたコメントを作成
    @comment = @travel_record.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:comment_comment, :user_id, :travel_record_id)
    end
end
