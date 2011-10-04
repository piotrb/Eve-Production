class DashboardController < ApplicationController
  def index

    if params[:q]
      @items = InvType.items.where("typeName like ?", "%#{params[:q]}%")
    else
      @items = []
    end

  end

  def info
    @item = InvType.items.find(params[:id])
  end

end
