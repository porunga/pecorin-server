class User < ActiveRecord::Base

	def self.create_with_omniauth(auth)
		begin
			create! do |user|
				user.facebook_id = auth['uid']
				user.access_token = auth['credentials']['token'] if auth['credentials']['token']
				user.pecorin_token = Digest::SHA256.hexdigest("#{auth['uid']}#{Time.now}")
				user.name = auth['info']['name'] if auth['info']['name']
				user.image_url = auth['info']['image'] if auth['info']['image']
			end
		rescue Exception
			raise Exception, "cannot create user record"
		end
	end

	def update_with_omniauth(auth)
		self.update_attributes({
			:access_token => auth['credentials']['token'],
			:pecorin_token => Digest::SHA256.hexdigest("#{self.facebook_id}#{Time.now}"),
			:name => auth['info']['name'],
			:image_url => auth['info']['image'],
		})
	end

end
