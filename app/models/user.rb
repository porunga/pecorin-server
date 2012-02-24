class User < ActiveRecord::Base

	def self.create_with_omniauth(auth)
		begin
			create! do |user|
				user.facebook_id = auth['uid']
				user.access_token = auth['credentials']['token'] if auth['credentials']['token']
				user.name = auth['info']['name'] if auth['info']['name']
				user.image_url = auth['info']['image'] if auth['info']['image']
			end
		rescue Exception
			raise Exception, "cannot create user record"
		end
	end

end
