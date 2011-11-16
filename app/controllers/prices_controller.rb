class PricesController < ApplicationController

  before_filter :require_login

  before_filter :get_location

  # GET /prices
  # GET /prices.xml
  def index
    @prices = @price_source.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prices }
    end
  end

  # GET /prices/1
  # GET /prices/1.xml
  def show
    @price = @price_source.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @price }
    end
  end

  # GET /prices/new
  # GET /prices/new.xml
  def new
    @price = @price_source.new
    @price.typeid ||= params[:typeid]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @price }
    end
  end

  # GET /prices/1/edit
  def edit
    @price = @price_source.find(params[:id])
  end

  # POST /prices
  # POST /prices.xml
  def create
    @price = @price_source.new(params[:price])

    respond_to do |format|
      if @price.save
        format.html { redirect_to :controller => :dashboard, :action => :info, :id => @price.typeid }
        format.xml  { render :xml => @price, :status => :created, :location => @price }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @price.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prices/1
  # PUT /prices/1.xml
  def update
    @price = @price_source.find(params[:id])

    respond_to do |format|
      if @price.update_attributes(params[:price])
        format.html { redirect_to :controller => :dashboard, :action => :info, :id => @price.typeid }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @price.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.xml
  def destroy
    @price = @price_source.find(params[:id])
    @price.destroy

    respond_to do |format|
      format.html { redirect_to :controller => :dashboard, :action => :info, :id => @price.typeid }
      format.xml  { head :ok }
    end
  end

protected

  def get_location
    if params[:location_id]
      @location = Location.find(params[:location_id])
      @price_source = @location.prices
    else
      @price_source = Price
    end
  end

end
