class CommentsController < ApplicationController
  def create
    @travel_record = TravelRecord.find(params[:travel_record_id])
    #投稿に紐づいたコメントを作成
    @comment = @travel_record.comments.build(comment_params).order(created_at: :desc)
    @comment.user_id = current_user.id
    @comment.save
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :travel_record_id)
    end
end
