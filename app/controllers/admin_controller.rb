
class AdminController < ApplicationController
  def login
  end

  def notes
  end

  def index
  end

  def flickr
		puts 'start...'
		require "flickr/7days"
	  FlickrDataExtractor.daily_fetch
		puts 'end....'
  end

  def beautifulphotonet
  end

  def sphotography
  end

  def picasaweb
  end

end
