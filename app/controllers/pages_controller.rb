class PagesController < ApplicationController
  def index

# If user is signed in, the profile page would be the root path, or else the Sign in would be the root path.

    if user_signed_in? 
      redirect_to current_user
    else
      redirect_to new_user_session_path
    end
  end
end
