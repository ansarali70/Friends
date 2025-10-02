class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except:[:index, :show ]
  before_action :correct_user, only:[:edit, :update, :destroy]

  # GET /friends
  def index
  if user_signed_in?
    @friends = current_user.friends
  else
    @friends = Friend.all # or [] if you want to hide friends when not logged in
  end
end


  # GET /friends/1
  def show
  end

  # GET /friends/new
  def new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  def create
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: "Friend was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  def destroy
    @friend.destroy!
    respond_to do |format|
      format.html { redirect_to friends_path, notice: "Friend was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice:"not Authorize to edit that friend" if @friend.nil?
  end

  private

    def set_friend
      @friend = current_user.friends.find(params[:id])
    end

    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :current_user_id)
    end
end
