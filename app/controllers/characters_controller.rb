class CharactersController < ApplicationController

  before_filter :require_login

  before_filter :get_collection
  before_filter :get_single, :only => [:show, :new, :edit, :create, :update, :destroy]

  respond_to :html, :xml, :json

  def index
    respond_with(@characters)
  end

  def show
    respond_with(@character)
  end

  def new
    respond_with(@character)
  end

  def edit
    respond_with(@character)
  end

  def create
    @character.attributes = params[:character]
    @character.save
    respond_with(@character, :location => characters_path, :notice => 'Character was successfully created.' )
  end

  def update
    @character.attributes = params[:character]
    @character.save
    respond_with(@character, :location => characters_path, :notice => 'Character was successfully updated.' )
  end

  def destroy
    @character.destroy
    respond_with(@character, :location => characters_path, :notice => 'Character was successfully deleted.' )
  end

protected

  def get_collection
    @characters = current_user.characters
  end

  def get_single
    if params[:id]
      @character = @characters.find(params[:id])
    else
      @character = @characters.build
    end
  end

end
