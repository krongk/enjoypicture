module PagesHelper
	include ActsAsTaggableOn::TagsHelper

	def randi
	  (rand*10).to_i
	end
end
