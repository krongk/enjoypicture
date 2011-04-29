# == Synopsis
#
# Daily Fetch phot from this site:
# http://www.flickr.com/explore/interesting/7days/
# 
require "rubygems"
require "nokogiri"
require "open-uri"

class FlickrDataExtractor
  def self.daily_fetch
	  FlickrDataExtractor.new.daily_fetch
  end

	def daily_fetch
	  page = nil
		begin
			url = "http://www.flickr.com/explore/interesting/7days/"
			doc = Nokogiri::HTML(open(url))
			doc.css(".TwentyFour .Photo").each do |p|
				next if p.nil?
				photo = p.css(".pc_img").first if p.css(".pc_img")
				unless photo.nil?
					# http://farm6.static.flickr.com/5268/5618990334_199d2d3350_m.jpg
					src = photo.attributes['src'].value unless photo.attributes['src'].nil?
					# get big size
					# http://farm6.static.flickr.com/5027/5624462978_42702f636c_z.jpg
					src = src.sub(/_(m)[.]/, '_z.')
					title = photo.attributes['alt'].value unless photo.attributes['alt'].nil?
					# 103/365 (Explored!) Chinese Pin Cushion by Ry
					title = title.sub(/ *\bby .*$/, '').sub(/\d+\/\d+/, '').strip unless title.blank?
					t = Time.now
					title = "#{t.year}-#{t.month}-#{t.day}-#{(rand*10).to_i.to_s}" if title.blank?
					page ||= save_to_db(nil, title, src)
				end
			end
			return page
		rescue => ex
		  puts ex.message
			return nil
		end
	end

	#save to file
	def save_to_db(tag_name, pic_name, pic_url)
	  return nil if pic_url.nil?

	  begin
			ActiveRecord::Base.transaction do
				#if exist
				unless Picture.find_all_by_global_path(pic_url).size > 0
					page = Page.create(:title => pic_name)
					if page = page.reload
						pic = Picture.create(:page_id => page.id, :title => pic_name, :global_path => pic_url)
						page.tag_list << tag_name unless tag_name.nil?
						page.save!
						return page
					end
				end
			end
			return nil
		rescue => ex
		  puts ex.message
			return nil
	  end
	end

end