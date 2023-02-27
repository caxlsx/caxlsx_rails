class UsersController < ApplicationController
  respond_to :xlsx, :html

  if Gem::Version.new("5.0") <= Rails.gem_version
    layout Proc.new { |c| return (c.request.format.symbol == :xlsx ? false : :default )}
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx
    end
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user) do |format|
      if Gem::Version.new("7.0") <= Rails.gem_version
        format.xlsx { render "respond_with" }
      else
        format.xlsx { render "respond_with.xlsx.axlsx" }
      end
    end
  end

  def send_instructions
    @user = User.find(params[:user_id])
    @user.send_instructions
    if Rails.gem_version < Gem::Version.new("5.0")
      render text: "Email sent"
    else
      render plain: "Email sent"
    end
  end

  def export
    @user = User.find(params[:id])
    respond_to do |format|
      format.xlsx do
        render xlsx: "export", filename: "export_#{@user.id}"
      end
    end
  end
end
