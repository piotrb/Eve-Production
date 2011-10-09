class LocationsController < ApplicationController

  before_filter :require_login

  before_filter :get_collection
  before_filter :get_single, :only => [:show, :new, :edit, :create, :update, :destroy]

  respond_to :html, :xml, :json

  def index
    respond_with(@locations)
  end

  def show
    respond_with(@location)
  end

  def new
    respond_with(@location)
  end

  def edit
    respond_with(@location)
  end

  def create
    @location.attributes = params[:location]
    @location.save
    respond_with(@location, :location => locations_path, :notice => 'Location was successfully created.' )
  end

  def update
    @location.attributes = params[:location]
    @location.save
    respond_with(@location, :location => locations_path, :notice => 'Location was successfully updated.' )
  end

  def destroy
    @location.destroy
    respond_with(@location, :location => locations_path, :notice => 'Location was successfully deleted.' )
  end

protected
  def get_collection
    @locations = current_user.locations
  end

  def get_single
    if params[:id]
      @location = @locations.find(params[:id])
    else
      @location = @locations.build
    end
  end

end
