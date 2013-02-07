class HomeController < ApplicationController
  def index
  end
  def page
    @id = params[:id]
    @items = ['red', 'green', 'yellow']
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end
end
