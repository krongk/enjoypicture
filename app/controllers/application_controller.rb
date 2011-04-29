class ApplicationController < ActionController::Base
  require 'extension' #lib/extension.rb
	require 'extractor' #lib/extractor.rb
  protect_from_forgery
end
