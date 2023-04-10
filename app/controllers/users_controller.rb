class UsersController < ApplicationController

  before_action :set_user
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def showmessage
    if params[:id].present?
        @user=User.find(params[:id])
        # user_id = 
        @users = User.all_except(current_user)

        @room=Room.new
        @rooms=Room.public_rooms
        @room_name=get_name(@user,current_user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(created_at: :asc)
        render 'rooms/index'
    else
      redirect_to root_path, notice: "Room not found"
    end
  end

  

  # To delete the account
  def destroy
    @user = current_user
    @user.interests.destroy_all
    @user.destroy
    flash[:success] = "Your account has been deleted."
    redirect_to root_path
  end

  def follow
    current_user.send_follow_request_to(@user)
    redirect_to user_path(@user)
  end

  def unfollow
    make_it_a_unfriend_request
    current_user.unfollow(@user)
    redirect_to user_path(@user)
  end

  def accept
    current_user.accept_follow_request_of(@user)

    store=@user.store
    if store.length < 10
      store.push(current_user.id)
    else
      store.shift
      store.push(current_user.id)
    end
    @user.update(store: store)
      
    make_it_a_friend_request
    
    redirect_to user_path(@user)
  end

  def decline
    current_user.decline_follow_request_of(@user)
    redirect_to root_path
  end

  def cancel
    current_user.remove_follow_request_for(@user)
    redirect_to root_path
  end




  private

  def set_user
    @user=User.find(params[:id])
  end

  def make_it_a_unfriend_request
    @user.unfollow(current_user) if @user.mutual_following_with?(current_user)
  end

  def make_it_a_friend_request
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)
  end

  def get_name(user1, user2)
    user=[user1,user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

end

