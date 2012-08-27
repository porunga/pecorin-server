require 'json'
require 'userinfuser/lib/userinfuser'
APP_KEY = '*********************'
USERINFUSER_ACCOUNT = "************************"

class Level < ActiveRecord::Base

  def self.update_count(facebook_id, type)
    level = Level.where(:facebook_id => facebook_id, :badge_type => type).first
    unless level
      level = Level.new
      level.level = 0
      level.level_name = ""
      level.image_url = ""
      level.facebook_id = facebook_id
      level.badge_type = type
      level.save
    end
    ui = UserInfuser.new(USERINFUSER_ACCOUNT,  APP_KEY, true, false, false, true) 
    case type
    when "c2dm"
      response = ui.award_badge_points(facebook_id,  "c2dm-#{level.level}-private",  10,  100 * (level.level + 1),  "c2dm")
    when "nfc"
      response = ui.award_badge_points(facebook_id,  "nfc-#{level.level}-private",  10,  50 * (level.level + 1),  "nfc")
    end
    level_name = response["badge"]["badgeRef"]["description"]
    image_url = response["badge"]["downloadLink"]
    result = {
      :current_point => response["now_points"],
      :leveled_up => true,
      :level_name => level_name,
      :image_url => image_url,
      :badge_type => type
    }
    if response["badge_awarded"] == "yes"
      level_num = level.level + 1
      level.update_attributes({:level => level_num, :level_name => level_name, :image_url => image_url})
      return result
    else
      result[:leveled_up] = false
      result[:level_name] = ""
      result[:image_url] = ""
      return result
    end
  end
end
