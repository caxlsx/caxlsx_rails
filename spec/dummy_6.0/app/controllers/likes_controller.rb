class LikesController < ApplicationController
  # GET /likes
  # GET /likes.json
  def index
    @user = User.find(params[:user_id])
    @likes = @user.likes

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx
    end
  end

  def render_elsewhere
    @user = User.find(params[:user_id])
    render :xlsx => "index", :template => 'users/index'
  end
end
