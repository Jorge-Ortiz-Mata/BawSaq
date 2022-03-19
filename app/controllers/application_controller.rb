class ApplicationController < ActionController::Base

    helper_method :current_user_logged_in?

    private
        def current_user_logged_in?
            if !current_user
                redirect_to new_user_session_path, alert: "Sorry, you must sign in in order to start."
            end
        end
        
end
