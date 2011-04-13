# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
	pages = Page.create([{ :title => 'Tiebet'}, {	:title => 'Sunflower'}])
	Picture.create([{:page_id => pages.first.id, :shortcut_path => 'tiebet.jpg', :width => 600}, {:page_id => pages.last.id, :shortcut_path => 'sunflower.jpg', :width => 600}])