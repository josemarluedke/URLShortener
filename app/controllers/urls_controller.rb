class UrlsController < ApplicationController
  def index
    @url = Url.new
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
    @url.ip_address = request.remote_ip
    
    if !@url.valid? and @url.errors[:link].any?
      url = Url.first :conditions => {:link => params[:url][:link]}
      @url = url if url
    end
    
    respond_to do |format|
      if @url.save
        format.html {redirect_to "#{root_path}#{@url.token}+", notice: "You have successfully shortened the URL."}
        format.json {render :json => @url, :status => :created}
      else
        format.html {render :action => "new"}
        format.json {render :json => @url.errors, :status => :unprocessable_entry}
      end
    end
  end
  
  def show
    return render_404 if params['token'].nil?
    @url = Url.first :conditions => {:token => params['token'].delete("+")}
    respond_to do |format|
      if @url
        format.html
        format.json {render :json => {:url => @url, :last_visits => @url.last_visits, :total_visits => @url.visits.count}}
      else
        return render_404
      end
    end
  end
  
  def redirect
    @url = Url.first :conditions => {:token => params['token']}
    respond_to do |format|
      if @url and not @url.link.nil?
        @url.new_visit :ip_address => request.remote_ip, :referral_link => request.env['HTTP_REFERER']
        format.html {redirect_to @url.link}
        format.json {render :json => @url}
      else
        return render_404
      end
    end
  end
end
