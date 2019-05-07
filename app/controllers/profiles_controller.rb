class ProfilesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def new
    @profile = Profile.new
  end

  def create
    @user = current_user
    # @profile = current_user.build_profile(profile_params)
    @profile = @user.create_profile(profile_params)
   if @profile.save
     flash[:success] = "Profile created!"
     redirect_to root_url
   else
     # @feed_items = []
     render 'static_pages/home'
   end
  end

  def index
    @profiles = Profile.all
  end

  def destroy
    @profile.destroy
    flash[:success] = "Profile deleted"
    redirect_to request.referrer || root_url
  end

  def edit
    @profile = current_user.profile
  end

  def update
  end

  private

    def profile_params
      params.require(:profile).permit(:content, :Related_links, :carrer, :portfolio, :role)
    end

    def correct_user
      @profile = current_user.profile.find_by(id: params[:id])
      redirect_to root_url if @profile.nil?
    end
end