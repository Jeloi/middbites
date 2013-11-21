class CommentsController < ApplicationController
	skip_before_filter :can_can_can

  def create
  	@comment = current_user.comments.build(comment_params)
  	respond_to do |wants|
  		if @comment.save
  			wants.js { render "comments/create" }
  		end
  	end
  	
  end

  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :comment)
  end
end
