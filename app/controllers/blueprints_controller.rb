class BlueprintsController < ApplicationController

    before_filter :require_login

    before_filter :get_collection
    before_filter :get_single, :only => [:show, :new, :edit, :create, :update, :destroy]

    respond_to :html, :xml, :json

    def index
      respond_with(@blueprints)
    end

    def show
      respond_with(@blueprint)
    end

    def new
      respond_with(@blueprint)
    end

    def edit
      respond_with(@blueprint)
    end

    def create
      @blueprint.attributes = params[:blueprint]
      @blueprint.save
      respond_with(@blueprint, :location => blueprints_path, :notice => 'Blueprint was successfully created.' )
    end

    def update
      @blueprint.attributes = params[:blueprint]
      @blueprint.save
      respond_with(@blueprint, :location => blueprints_path, :notice => 'Blueprint was successfully updated.' )
    end

    def destroy
      @blueprint.destroy
      respond_with(@blueprint, :location => blueprints_path, :notice => 'Blueprint was successfully deleted.' )
    end

  protected

    def get_collection
      @blueprints = current_user.blueprints
    end

    def get_single
      if params[:id]
        @blueprint = @blueprints.find(params[:id])
      else
        @blueprint = @blueprints.build
        if params[:typeid]
          @blueprint.typeid = params[:typeid]
        end
      end
    end

end
