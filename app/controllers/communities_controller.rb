class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:  [:destroy, :new, :edit]
  respond_to :html

  def index
    @communities = Community.all
    respond_with(@communities)
  end

  def show
    respond_with(@community)
  end

  def new
    @community = Community.new
    respond_with(@community)
  end

  def edit
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      redirect_to community_by_name_path(@community.name), notice: 'Community successfully created.'
    else
      render :new
    end

  end

  def update
    @community.update(community_params)
    respond_with(@community)
  end

  def destroy
    @community.destroy
    respond_with(@community)
  end

  def subscribe
    @community = Community.find_by_name(params[:community_id])
    current_user.update_subscription @community
    redirect_to community_by_name_path(@community.name)
  end

  private
    def set_community
      @community = Community.find_by_name(params[:id])
    end

    def community_params
      params.require(:community).permit(:name, :private, :description)
    end
end
