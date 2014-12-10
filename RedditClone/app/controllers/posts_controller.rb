class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:  [:destroy, :new, :edit]
  respond_to :html, :js

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
      @posts = Post.subscriptions(current_user)
    end

    @posts.to_a.sort_by! { |post| post.created_at }
    @posts = Kaminari.paginate_array(@posts.reverse).page params[:page]
    respond_with @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.root_comments.order('created_at desc')

    if current_user
      @comment = Comment.build_from(@post, current_user.id, "")
      @community_user = current_user.communities.new
    end

    @community = @post.community

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
    @post.save
    @post.liked_by @post.user
    respond_with @post
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
    if current_user && current_user.voted_up_on?(@post)
      @post.unliked_by current_user
    else
      @post.liked_by current_user
    end
    redirect_to post_path(@post, format: :js)
  end

  def downvote
    @post = Post.find params[:post_id]
    if current_user && current_user.voted_down_on?(@post)
      @post.undisliked_by current_user
    else
      @post.downvote_by current_user
    end
    redirect_to post_path(@post, format: :js)
  end

  def reply

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      if params[:community]
        @community = Community.find_by_name(params[:community])
        @posts =  @community.posts
        if @community.community_users.empty?
          @community_user = @community.community_users.new
        else
          @community_user = @community.community_users.last
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:id, :title, :url, :text, :community_id)
    end
end
