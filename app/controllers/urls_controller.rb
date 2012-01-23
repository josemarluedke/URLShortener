class UrlsController < ApplicationController
  def index
  end

  def new
    @url = Url.new
    respond_to do |format|
      format.html
      format.json {render :json => @url}
    end
  end

  def create
    respond_to do |format|
      format.html
      format.json {render :json => {:success => true}}
    end
  end
end
