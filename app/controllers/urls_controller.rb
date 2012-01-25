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
    @url = Url.new params[:url]
    
    if !@url.valid? and @url.errors[:link].any?
      url = Url.first :conditions => {:link => params[:url][:link]}
      @url = url if url
    end
    
    respond_to do |format|
      if @url.save
        format.html
        format.json {render :json => @url, :status => :created}
      else
        format.html {render :action => "new"}
        format.json {render :json => @url.errors, :status => :unprocessable_entry}
      end
    end
  end
end
