class UsersController < ApplicationController
  respond_to :xlsx, :html
  layout Proc.new { |c| return (c.request.format.symbol == :xlsx ? false : :default )}

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
      format.xlsx { render "respond_with.xlsx.axlsx" }
    end
  end

  def send_instructions
    @user = User.find(params[:user_id])
    @user.send_instructions
    render plain: "Email sent"
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
