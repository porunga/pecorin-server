require 'json'

class SessionsController < ApplicationController

	def create
		auth = request.env["omniauth.auth"]
		@user = User.where(:facebook_id => auth['uid']).first || User.create_with_omniauth(auth)
		session[:user_id] = @user.id
		redirect_to :action => "success"
	end

	def success
		user = User.where(:id => session[:user_id]).first || nil
		response = {:name => user.name, :facebook_id => user.facebook_id}
		@json = response.to_json
	end

	def failure
		response = {:error => params[:message].humanize}
		@json = response.to_json
	end

	def new
		return redirect_to "/auth/facebook"
	end

	def destroy
		session[:user_id] = nil
		#redirect_to "/", :notice => "Signed out!"
	end

end
