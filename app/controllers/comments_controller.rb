class CommentsController < ApplicationController

  def create
  	@comment = current_user.comments.build(comment_params)
  	respond_to do |wants|
  		if @comment.save
  			wants.js { render "comments/create" }
  		end
  	end
  	
  end

  def load_comments
    @recipe = Recipe.friendly.find(params[:id])
    @comments = @recipe.comments.order(:created_at => :desc).offset(10)
    logger.debug { @comments.size }
    logger.debug { @comments }
  end

  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :comment)
  end
end
