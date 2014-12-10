class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    # Not implemented: check to see whether the user has permission to create a comment on this object
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    if @comment.save
      render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
    else
      render :js => "alert('error saving comment');"
    end
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('error deleting comment');"
    end
  end

  def upvote
    @comment = Comment.find params[:comment_id]
    if current_user && current_user.voted_up_on?(@comment)
      @comment.unliked_by current_user
    else
      @comment.liked_by current_user
    end
    render :show
  end

  def downvote
    @comment = Comment.find params[:comment_id]
    if current_user && current_user.voted_down_on?(@comment)
      @comment.undisliked_by current_user
    else
      @comment.downvote_by current_user
    end
    render :show
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
