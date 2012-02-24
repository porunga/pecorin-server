require 'json'

class UserController < ApplicationController

	before_filter :is_authenticated?

	def show
		user = find_user_by_auth
		render :json => user.to_json, :status => :ok
	end

end
