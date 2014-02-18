class CommentsController < ApplicationController
  skip_before_filter :cancan_bug_fix
  # load_and_authorize_resource :comment, :find_by => :id

  def create
    authorize! :create, Comment
    @comment = current_user.comments.build(comment_params)
  	respond_to do |wants|
  		if @comment.save
  			wants.js { render "comments/create" }
  		end
  	end
  	
  end

  def load_comments
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @comments = @recipe.comments.order(:created_at => :desc).offset(10)
    logger.debug { @comments.size }
    logger.debug { @comments }
  end

  def destroy
    authorize! :destroy, @comment
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :comment, :recipe_id)
  end
end
