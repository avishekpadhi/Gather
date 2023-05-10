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

      elsif  @experience != "" and @interestquery == ""
    @user_names=[]


    #____----------------------------------------

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

  def feed
    @current=current_user
    @followers=@current.followers
    @interests=@current.interests
    @all_users=[]

    
    
    # @interest = @interests[rand(@interests.length)]
      @interests.each do |interest| 
      @users=User.joins(:interests).where(interests: { name: interest.name })
      @interest_name=interest.name
      @object = { @interest_name => @users }
      @all_users.append(@object)
    # @user_ids.each do |id|
    #   @user=User.find(id)
    #   if @user != @current
    #     @all_users.append(@user)
    #     puts(@all_users)
      end

      
    # end

    
    @feedposts=[]
    @allposts=[]
    
    
    @interests.each do |interest| 

      @posts=Post.where("category LIKE ?", "%#{interest.name}%")
      @posts.each do |post|
        if @current.mutual_following_with?(post.user) || @current == (post.user)
          @feedposts.append(post)
        end
      end
      

      @posts.each do |post|
        @comment=post.comments.build
      end
      @allposts.concat(@posts).shuffle

      

    end
    @show_all_posts= params[:show_all_posts] == "1"

  
   

    
  end

  def acceptnotif
    @notif_users=[]
    @notif=current_user.store
    @notif.each do |notif|
      @user=User.find(notif)
      @notif_users.append(@user)
  end


  end

  private

  def getname(id)
    @name=User.find(id)
  end
end
