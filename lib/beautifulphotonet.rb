# encoding: utf-8
require 'open-uri'

class Download::BeautifulPhotoNet
  def run
  	puts 'run..'
  	@file_path = 'lib/download/beautifulphotonet'
  	Photo.order(:id).where(:is_processed => 'n').each do |photo|
  		sleep(5)
  		begin
	  		#- format title
	  		# SELECT * from photo where name not REGEXP '^[a-z0-9 .,''?_+:!~/)(-]+$' LIMIT 50;
				# Permanent Link to about face.
				title = photo.name
				title = title.gsub(/^Permanent Link to */i, '')
				title = title.gsub(/,|\'|\?|~|!/, '').gsub(/[ ]+|\.|\_|\+|\:|\/|\(|\)/, '-')
				#remove chinese name '¶ñÍ¯-Tekkon-Kinkreet-'
				title = title.gsub(/[^a-z0-9-]/i, '')
			  #--About-a-rose-in-hairs---
			  title = title.gsub(/^-+/i, '').gsub(/-+$/i, '').squeeze('-')

				#- get file name
				file_name = @file_path + '/' + title + '.jpg'
#				while File.exists?(file_name)
#				  file_name = @file_path + '/' + title + '-' + (rand*1000).to_i.to_s + '.jpg'
#			  end

			  # file_name = "lib/download/beautifulphotonet/afe-bb.jpg"
			  # local_path = 'afe-bb.jpg'
			  name_arr = file_name.split(/\//)
			  local_path = name_arr.pop
			  # add photo.id '1-afe-bb.jpg'
			  local_path = photo.id.to_s + '-' + local_path
			  name_arr << local_path
			  file_name = name_arr.join('/')
			  
			  #- download file
			  File.open(file_name, 'wb') do |output|
			    open(photo.url) do |input|
			    	 output << input.read
			    end
			  end
			  #- update flag
			  puts local_path
			  Photo.update(photo.id, :is_processed => 'y', :local_path => local_path)
		  rescue => ex
		    puts ex.message
		    #photo.messages.create(:description => ex.message)
		    File.delete(file_name)
		    Photo.update(photo.id, :is_processed => 'f')
		  end
    end #end each 
    #repair files
    repair_records
    return nil
  end
  # because there are 65 records has file, but at database, the :local_path is null
  def repair_records
    @file_path ||= 'lib/download/beautifulphotonet'
    files = Dir.glob("#{@file_path}/*.jpg").map{|f| f.split('/').pop }
    Photo.where("is_processed = 'y' and local_path is NULL").each do |photo|
    	 file_name = files.select{|f| f =~ /^#{photo.id}-/ }.first
    	 puts file_name
    	 Photo.update(photo.id, :is_processed => 'm', :local_path => file_name)
    end
    return nil
  end
end
Download::BeautifulPhotoNet.new.run if __FILE__ == $0

=begin
 for test
 		rails console -s
	 	require 'download'
		Download::BeautifulPhotoNet.new.run
=end

#The first methods
#	image_url = "http://www.beautifulphoto.net/upload/201006281148452886.jpg"
#	file_path = "Photos/beautifulphotonet/b.jpg"
#	
#	unless File.exists?(file_path)
#		#Make sure you must set file 'w' and 'b'(binary)
#	  File.open(file_path, 'wb') do |output|
#	    # Download image
#	    open(image_url) do |input|
#	      output << input.read
#	    end
#	  end
#	end

#The second methods
#	require 'net/http'
#	
#	Net::HTTP.start("www.beautifulphoto.net") { |http|
#	  resp = http.get("/upload/201006281148452886.jpg")
#	  open("Photos/beautifulphotonet/a.jpg", "wb") { |file|
#	    file.write(resp.body)
#	   }
#	}

#test ruby lib/download/beautifulphotonet.rb