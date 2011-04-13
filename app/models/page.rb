class Page < ActiveRecord::Base
	has_one :picture
	# Alias for <tt>acts_as_taggable_on :tags</tt>:
	acts_as_taggable
	acts_as_taggable_on :tags, :skills
end
