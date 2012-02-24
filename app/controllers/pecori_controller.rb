# -*- coding: utf-8 -*-
class PecoriController < ApplicationController
  protect_from_forgery :except => :create

 def create
   pecorer_facebook_id = params["pecorer_facebook_id"]
   pecoree_facebook_id = params["pecoree_facebook_id"]

   @pecoree_user = User.find_by_facebook_id(pecoree_facebook_id)
   @pecorer_user = User.find_by_facebook_id(pecorer_facebook_id)
   if @pecoree_user and @pecorer_user
     pecoree_registration_id = @pecoree_user.registration_id 
     pecorer_name = @pecorer_user.name
 
     token = C2dmAccess.get_client_login()
     message = {:message => pecorer_name + "さんがぺこりしてます！" }
     if C2dmAccess.c2dm_post_message(pecoree_registration_id, token, message)
       render :text =>  "Success to send a message", :status => 200
       else 
       render :text =>  "Failure to send a message", :status => 500
     end
   end
 end

end
