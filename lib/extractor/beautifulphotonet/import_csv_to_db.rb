#==Synopsis
# How to parse CSV data with Ruby
#	Parsing with plain Ruby
#	 filename = 'data.csv'
#	 file = File.new(filename, 'r')
#	 
#	 file.each_line("\n") do |row|
#		 columns = row.split(",")
#		 
#		 break if file.lineno > 10
#	 end
#	This option has several problems¡­
#
#	Parsing with the CSV library
#	 require 'csv'
#	 
#	 CSV.open('data.csv', 'r', ';') do |row|
#		 p row
#	 end

require "csv"

class ImportCsv

	def run
		puts "please input the csv file:"

		csv = gets.chomp

		unless File.exist?(csv)
			raise 'bad csv file path'
		end

		CSV.open(csv, 'r', "\t") do |row|
			save_to_db(row[0],row[1],row[2])
		end
	end
	#save to file
	def save_to_db(tag_name, pic_name, pic_url)
	  begin
			ActiveRecord::Base.transaction do 
				page = Page.create(:title => pic_name)
				if page = page.reload
					pic = Picture.create(:page_id => page.id, :title => pic_name, :global_path => pic_url)
					page.tag_list << tag_name
					page.save!
				end
				puts pic_name
			end
		rescue => ex
		  puts ex.message
	  end
	end
end

ImportCsv.new.run if __FILE__ == $0

=begin 
	rails console
require 'lib/beautifulphotonet/import_csv_to_db.rb'
ImportCsv.new.run
C:\Users\Administrator\Documents\NetBeansProjects\enjoypicture\lib\beautifulphotonet\beautifulphotonet.csv
=end