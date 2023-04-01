class ProfilesController < ApplicationController
  def search
    @query = params[:query]
    @users = User.where("name LIKE ?", "%#{@query}%")
  end

  def followrequests
    @current=current_user.follow_requests
  end
end
