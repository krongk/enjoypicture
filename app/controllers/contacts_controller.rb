class ContactsController < ApplicationController
  before_filter :login_require, :except => ['login','new', 'create']
	layout 'baoxian028'

	def login_require
	  if session[:user].nil?
		  redirect_to "/login"
	  end
	end

	def login
	  if ['admin','master','baoxian028', 'test'].include?(params[:name])
			if ['kenrome','nasha','028baoxian', 'baoxian028.com'].include?(params[:pass])
			  session[:user] = params[:name]
				client_ip = request.remote_ip
				ContactLog.create(:msg => "#{session[:user]} - #{client_ip = request.remote_ip} - #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}")
				redirect_to "/contacts"
			else
			  flash[:notice] = '密码错误'
			end
	  else
		  flash[:notice] = '用户名错误'
		end
	end

	def logout
	  session[:user] = nil
		redirect_to "/contacts"
	end
	# GET /contacts
  # GET /contacts.xml
  def index
	  if ['admin', 'master'].include?(session[:user])
			@contacts = Contact.order("created_at desc").paginate(:page => params[:page]||1, :per_page => 24)
		else
			@contacts = Contact.where(:is_visiable => 'y').order("created_at desc").paginate(:page => params[:page]||1, :per_page => 20)
	  end
    
		@contact_logs = ContactLog.order("created_at desc").limit(20)
	  #@posts = Post.paginate_by_board_id @board.id, :page => params[:page], :order => 'updated_at DESC'
		#@topics = Topic.where(:catalog_id=>@catalog.id).order("updated_at desc").paginate(:page=>params[:page]||1,:per_page=>10) 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { render :text => "谢谢您的留言，客服人员会在24小时之内尽快与您取得联系！<div>请点击右上角<img src='images/x.png' alt='close' />图标关闭窗口</div>" }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(contacts_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # filter messages, only admin can see
  def destroy
    @contact = Contact.find(params[:id])
    #@contact.destroy
		@contact.is_destroy = 'y'
		@contact.save

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

	#clear ContactLog's after 20 records
	def clear_log
	  ContactLog.find_each do |log|
		  log.destroy
	  end
		redirect_to(contacts_url)
	end
end
