module SessionsHelper

    def logged_in_user
      #checks to see if current_user is a user. If not, we need to create one!
	  if current_user == nil
        user = User.create
        log_in(user)
      end
    end

	def log_in(user)
    	session[:user_id] = user.id
    	cookies.permanent.signed[:user_id] = user.id
  	end

	def current_user
	    if (user_id = session[:user_id])
	      #will return a user if the id exists in the session
	      @current_user ||= User.find_by(id: user_id)
	    elsif (user_id = cookies.signed[:user_id])
	      #will return a user if the id exists in a cookie
	      @current_user ||= User.find_by(id: user_id)
	    else
	      #will return nil if user_id isn't in session or cookie
	    end
	end

end
