class ApplicationController < ActionController::Base
  protect_from_forgery

	private

	def is_authenticated?
                auth = params[:auth]
                user = User.where(:pecorin_token => auth).first
                redirect_to :controller => "sessions", :action => "failure" unless user
        end

        def find_user_by_auth
		auth = params[:auth]
                User.where(:pecorin_token => auth).first
        end

end
