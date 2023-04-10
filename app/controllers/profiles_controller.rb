class ProfilesController < ApplicationController

  def search


    @current = current_user
    @query = params[:query]
    @interestquery=params[:interestquery]
    @experience = params[:filter]

    if @experience == ""
    # ----------------------------------------------------------------------

        @user_names = User.where("name LIKE ? AND city = ?", "%#{@query}%","#{@current.city}")


        if @query == ""
          @user_names=[]
        end

    # ------------------------------------------------------------------

    else

    @interests = Interest.where("name LIKE ? AND experience = ?", "%#{@interestquery}%","#{@experience}")
    @user_ids = []
    @user_names=[]

        @interests.each do |interest|
          @user_ids.append(interest.user_id)
        end

        @user_ids.each do |id|
          @user=User.find(id)
          if @user.city == @current.city
               @user_names.append(@user)
          end
        end
    end

    # ------------------------------------------------------------------------------

  end

  def followrequests
    @current=current_user.follow_requests
  end
  def acceptnotif
    @notif_users=[]
    @notif=current_user.store
    @notif.each do |notif|
      @user=User.find(notif)
      @notif_users.append(@user)
    end
  end
end
