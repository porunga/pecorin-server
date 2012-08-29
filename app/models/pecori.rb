class Pecori < ActiveRecord::Base

  belongs_to :pecorer, :class_name => "User", :foreign_key => "pecorer_id"
  belongs_to :pecoree, :class_name => "User", :foreign_key => "pecoree_id"

  def is_reply?
    if pecori = Pecori.where(:pecorer_id => self.pecoree_id, :pecoree_id => self.pecorer_id).first
      #    if pecori = Pecori.where(:pecorer_id => self.pecoree_id, :pecoree_id => self.pecorer_id, :pecori_type => self.type).first
      return pecori
    else
      return nil
    end
  end
  
  def is_sendable?
    time_limit = 1.days

    pecori = Pecori.where(:pecorer_id => self.pecorer_id, :pecoree_id => self.pecoree_id).first
#    pecori = Pecori.where(:pecorer_id => self.pecorer_id, :pecoree_id => self.pecoree_id, :pecori_type => self.type).first
    if pecori and ( pecori.updated_at + time_limit ) > Time.now
      return false
    else
      pecori.destory if pecori
      return true
    end

  end

  # this method don't check type
  def self.find_reply_user_ids(user)
    pecoree_ids = Pecori.where(:pecoree_id => user.id).pluck(:pecorer_id)

    result = []
    pecoree_ids.each do | pecoree_id |
      pecori = Pecori.new(:pecorer_id => user.id, :pecoree_id => pecoree_id)

      if pecori.is_sendable?
        result << pecoree_id
      end
    end

    return result
  end

end
