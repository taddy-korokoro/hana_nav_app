$("#comments_area").html("<%= j(render 'index', { comments: @comment.travel_record.comments }) %>")
$("textarea").val('')