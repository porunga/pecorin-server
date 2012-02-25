require 'json'
require 'big_door'
APP_KEY = '********'
APP_SECRET = '********'

class Level < ActiveRecord::Base

	def self.update_count(user, type)
		client = BigDoor::Client.new(APP_SECRET, APP_KEY)
		end_user = BigDoor::EndUser.new({'end_user_login' => user.facebook_id})
		begin
			end_user.load(client, user.facebook_id)
		rescue
			end_user.save(client)
		end

		ntg = BigDoor::NamedTransactionGroup.new
		nt = BigDoor::NamedTransaction.new
		case type
		when :c2dm	
			ntg.load(client, 731800)
			nt.load(client, 828089)
		when :nfc
			ntg.load(client, 731801)
			nt.load(client, 828090)
		end
		ntg.associate_with(nt, client, 1)
		response = ntg.execute(user.facebook_id, {'good_reciever' => user.facebook_id}, client)
		return nil unless Hash === response
		p response["end_user"]
		level_num = response["end_user"]["level_summaries"].size
		level_name = response["end_user"]["level_summaries"].first["pub_title"]
		image_url = response["end_user"]["level_summaries"].first["urls"].first["url"]
		result = {
			:current_point => response["end_user"]["currency_balances"].first["current_balance"],
			:leveled_up => true,
			:level_name => level_name,
			:image_url => image_url,
			:badge_type => type
		}
		level = Level.where(:user_id => user.id, :badge_type => type).first
		if level
			if level.level != level_num
				level.update_attributes({:level => level_num, :level_name => level_name, :image_url => image_url})
				return result
			else
				result[:leveled_up] = false
				result[:level_name] = ""
				result[:image_url] = ""
				return result
			end
		else
			Level.create({:user_id => user.id, :level => level_num, :level_name => level_name, :image_url => image_url, :badge_type => type})
			return result
		end
	end

end
