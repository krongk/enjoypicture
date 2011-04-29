module StringExtension
  def blank?
	  self.nil? || self.strip.length == 0
  end
end

class String
  include StringExtension
end

class NilClass
  include StringExtension
end