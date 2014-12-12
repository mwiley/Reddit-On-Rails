class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:  [:destroy, :new, :edit]
  respond_to :html, :js, :json

  # GET /posts
  # GET /posts.json
  def index
    # viewing a specific community's posts
    if params[:community]
      @community = Community.find_by_name(params[:community])
      @posts =  @community.posts
    # viewing the main page
    else
      @posts = Post.subscriptions(current_user)
    end

    # sort and paginate the results
    @posts = Post.sort(@posts, params[:sortby])
    @posts = Kaminari.paginate_array(@posts.reverse).page params[:page]
    respond_with @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # get all the root comments, ones that are the start of a thread
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
    @post.upvote current_user
    redirect_to post_path(@post, format: :js)
  end

  def downvote
    @post = Post.find params[:post_id]
    @post.downvote current_user
    redirect_to post_path(@post, format: :js)
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
      params.require(:post).permit(:id, :title, :url, :text, :community_id, :sortby)
    end
end
