class PagesController < ApplicationController
  caches_page :tag_cloud, :tag, :show

	# GET /pages
  # GET /pages.xml
  def index
    #@pages = Page.all.paginate :page => params[:page]||1, :per_page => 6, :order => 'updated_at DESC'
		@page = Page.order('random()').limit(3).first
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  def daily
		@page = Page.order('random()').limit(3).first
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end


	def add_tag
	  @page = Page.find(params[:id])
	  tag_str = params[:name]
		@page.tag_list << tag_str
		@page.save
		redirect_to pages_url
	end

	def tag_cloud
    @tags = Page.tag_counts_on(:tags)
  end

	def tag	
		@pages = Page.tagged_with(params[:id]).paginate :page => params[:page]||1, :per_page => 1
	end
  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

end
