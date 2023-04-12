class RoomsController < ApplicationController

  before_action :authenticate_user!

  def index
    @room=Room.new
    @rooms = Room.public_rooms

    # @single_room=Room.find(params[:id])
    @users = User.all_except(current_user)

    @followers = current_user.followers
        @q = params[:q]

        if @q.present?
          puts(@q)
           
            @followers = @followers.where("name LIKE ?", "%#{@q}%")
            puts (@followers)
        
        end
    

   
    # @q = @followerss.ransack(params[:q])
    # @followers = @q.result(distinct: true)
    

    render 'index'

  end

  def show
    @single_room=Room.find(params[:id])
    @room=Room.new
    @rooms = Room.public_rooms

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users=User.all_except(current_user)
    render 'index'
  end

  def create
    @room = Room.create(name:params["room"]["name"])
  end
end
