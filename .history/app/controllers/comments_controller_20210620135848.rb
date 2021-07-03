class CommentsController < ApplicationController
  def create
    @travel_record = TravelRecord.find(params[:travel_record_id])
    @comment = @travel_record.comments.build(comment_params)
    @comment.user_id = current_user.travel_record_id
    @comment.save
    render :index
  end

  def destroy

  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :travel_record_id)
    end
end
