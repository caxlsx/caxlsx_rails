class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx
    end
  end

  def send_instructions
    @user = User.find(params[:user_id])
    @user.send_instructions
    render text: "Email sent"
  end
end
