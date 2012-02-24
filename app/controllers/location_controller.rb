class LocationController < ApplicationController
  def update
    user = User.where(:id => params[:uid]).first || nil
    user.update_attribute(:current_location_id, params[:current_location_id])
    render :json => {:messate => "ok"}
  end
end
