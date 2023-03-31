class ProfilesController < ApplicationController
  def search
    @query = params[:query]
    @users = User.where("email LIKE ?", "%#{@query}%")
  end
end
