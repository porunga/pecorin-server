require 'json'

class UserController < ApplicationController

	before_filter :is_authenticated?

	def show
		user = find_user_by_auth
		render :json => user.to_json, :status => :ok
	end

	def index
		if params[:target] == "near"
			user = find_user_by_auth
			if user.current_location_id
				users = User.where(:current_location_id => user.current_location_id)
			else
				users = []
			end
		else
			users = User.all
		end
		render :json => users.to_json, :status => :ok
	end

end
