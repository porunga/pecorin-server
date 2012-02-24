class SessionsController < ApplicationController

	def create
		auth = request.env["omniauth.auth"]
		@user = User.where(:facebook_id => auth['uid']).first || User.create_with_omniauth(auth)
		session[:user_id] = @user.id
	end

	def failure
		#redirect_to "/", :alert => "Authentication error: #{params[:message].humanize}"
	end

	def new
		return redirect_to "/auth/facebook"
	end

	def destroy
		session[:user_id] = nil
		#redirect_to "/", :notice => "Signed out!"
	end

end
