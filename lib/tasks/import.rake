require "csv"

desc "Import tags from lib/csvs/tags.csv"
task :import_tags => [:environment] do
	csv = CSV.read('lib/csvs/tags.csv', headers: true, :encoding => 'windows-1251:utf-8', skip_blanks: true)		
	
	csv.headers.each do |header|

		tag_category = TagCategory.find_or_create_by(name: header)

		csv[header].each do |word|
			unless word.blank?
				tag = Tag.find_or_initialize_by(name: word)
				tag.tag_category = tag_category
				puts tag
				tag.save	
			end
		end
	end
end

desc "Delete unneccessary tag categories"
task :delete_tag_categories => [:environment] do
	TagCategory.where(name: "Miscellaneous").each do |tag_cat|
		tag_cat.tags.each do |tag|
			tag.tag_category = TagCategory.first
			tag.save
		end
		tag_cat.destroy
	end
end