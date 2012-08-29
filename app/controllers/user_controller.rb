# -*- coding: utf-8 -*-
require 'json'

class UserController < ApplicationController

  before_filter :is_authenticated?
  
  def show
    user = find_user_by_auth
    render :json => user.to_json, :status => :ok
  end
  
  def index
    
    user = find_user_by_auth

    if params[:mode] == "reply"
      user_ids = Pecori.find_reply_user_ids(user)
      users = User.where(:id => user_ids)
    else
      users = User.scoped
    end

    if params[:target] == "near"
      if user.current_location_id
        users = users.where(:current_location_id => user.current_location_id)
      else
        users = []
      end
    end

    render :json => users.to_json, :status => :ok
  end
  
end
