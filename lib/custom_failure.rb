class CustomFailure < Devise::FailureApp
    def respond
        if http_auth?
            http_auth
        else
            # You need to override respond to eliminate recall
            redirect_to login_path
        end
    end
end
