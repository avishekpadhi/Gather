class ApplicationController < ActionController::Base
    before_action :check_interests_count

    private
  
    def check_interests_count
        if user_signed_in? && current_user.interests.count < 4 && !devise_controller? && request.path != new_interest_path && !request.post?
            redirect_to new_interest_path, alert: "Please add at least 4 interests before proceeding."
          end
    end
end
