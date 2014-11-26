class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:  [:destroy, :new, :edit]
  respond_to :html

  # GET /posts
  # GET /posts.json
  def index
    if params[:community]
      @community = Community.find_by_name(params[:community])
      @posts =  @community.posts
      if @community.community_users.empty?
        @community_user = @community.community_users.new
      else
        @community_user = @community.community_users.last
      end

    else
      if current_user
        @posts = current_user.subscribed
      else
        @posts = Post.all
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
    @comment = @post.comments.new
    @comment.user = current_user

    @community = @post.community
    @community_user = current_user.communities.new

    @post_vote = @post.post_votes.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post = Post.find params[:post_id]
    @post.liked_by current_user
    redirect_to post_path(@post)
  end

  def downvote
    @post = Post.find params[:post_id]
    @post.downvote_by current_user
    redirect_to post_path(@post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:id, :title, :url, :text, :community_id)
    end
end
