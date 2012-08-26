# -*- coding: utf-8 -*-
require 'json'

class PecoriController < ApplicationController
  protect_from_forgery :except => :create

 def create
   pecorer_facebook_id = params["pecorer_facebook_id"]
   pecoree_facebook_id = params["pecoree_facebook_id"]
   type = params["type"]

   @pecoree_user = User.find_by_facebook_id(pecoree_facebook_id)
   @pecorer_user = User.find_by_facebook_id(pecorer_facebook_id)
   if @pecoree_user and @pecorer_user
     pecoree_registration_id = @pecoree_user.registration_id 
     pecorer_name = @pecorer_user.name

     pecori_message = "Pecori from " + pecorer_name
     registration_ids = [ pecoree_registration_id ]
     data = {"message" => pecori_message }
     gcm_result, gcm_result_message = GcmAccess.gcm_post_message(registration_ids, data)
     if gcm_result
       result = Level.update_count(pecorer_facebook_id, type)
#       for debug
#       result = { "current_point" => "100", "leveled_up" => "true", "level_name" => "Master", "image_url" => "hoge", "badge_type" => "fuga" }
       if result
         render :json =>  result.to_json, :status => 200
       else 
         render :text => "Success to send a message, but failed to update score", :status => 500
       end
     else 
       render :text =>  "Failure to send a message", :status => 500
     end
   end
 end

end
