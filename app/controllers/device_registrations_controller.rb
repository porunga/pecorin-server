class DeviceRegistrationsController < ApplicationController
  protect_from_forgery :except => :create

  def create
    facebook_id = params["facebook_id"]
    registration_id = params["registration_id"]

    if @user = User.find_by_facebook_id(facebook_id)
      @user.registration_id = registration_id
      if @user.save
        render :text =>  "Completion of registration!", :status => 201
      else
        render :text =>  "Failure to register", :status => 500
      end
    else
      render :text =>  "Failure to register", :status => 500
    end
  end

end
