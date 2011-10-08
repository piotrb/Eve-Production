class DashboardController < ApplicationController
  def index

    if params[:q]
      @items = InvType.items.where("typename ilike ?", "%#{params[:q]}%")
    else
      @items = []
    end

  end

  def info
    @item = InvType.items.find(params[:id])
  end

end
