require 'open-uri'

module MenuScraper
	HALL_MEAL_SORT = [ "Proctor", "Ross", "Atwater", "Breakfast", "Lunch", "Dinner"]

	# Visits the given base_url + date_param and scrapes middlebury menu info, optionally sorted by dining_hall
	def self.scrape_midd_menus(base_url, date_param="", sort_by="")

		# url = (!date_param.blank? ? base_url + "/" + date_param : base_url) # append date_param if it isn't blank
		url = base_url
		doc = Nokogiri::HTML(open(url))
		
		h3_nodes = doc.css(".view-content h3").to_ary.delete_if {|node| node.text == "Grille"}	# filter out the Grille
		dining_halls = {}
		h3_nodes.each do |hall|	# Build the keys of the hash, with raw nodes as values
			dining_halls[hall.text] = hall.next_element	# tables
		end

		
		
		# Build the nested hash, with dining hall being the top level key
		dining_halls.each do |key, node|

			meals = node.css("td") # each td (represents a meal)
			meal_times_hash = {}
			meals.each do |m|
				meal = []	# array to hold strings representing that meal
				meal_time = m.css("span.views-field-field-meal span.field-content").text # e.g "Lunch", "Dinner"
				foods = m.css("div.views-field-body .field-content p").children.to_ary.delete_if {|node| node.name == "br"} # remove the br tags
				foods.each do |food| # just text nodes
					f = food.text.gsub("\n", "") # remove the newline char
					meal << f
				end
				meal_times_hash[meal_time] = meal
			end
			dining_halls[key] = meal_times_hash
		end

		
		# Custom sort the keys of the dining hall hash
		dining_halls =  sort_hash_by_array(dining_halls)
		
			
		if sort_by == "dining_hall"
			return dining_halls
		else	# sorted_by dining hall
			# Transpose this hash so that meal time is the top level key
			meal_times = Hash.new{ |h,k| h[k] = {} }	# new hash, default values are empty hashes
			dining_halls.each_pair do |hall, meal_hash|
				meal_hash.each_pair do |meal_time, meal|
					meal_times[meal_time][hall] = meal
				end
			end
			return sort_hash_by_array(meal_times)
		end
	end

	# Sorts a given hash by its keys, on the given array. Keys that aren't in the array are put at the end
	# note keys not in array are given 99 as sort value. Shouldn't be an issue with this data.
	def self.sort_hash_by_array(hash, array=HALL_MEAL_SORT)
		Hash[hash.sort_by{|k, _| array.index(k) || 99 }]
	end

	# TODO: TEST this function for duplicate items, make sure uniqueness is case insensitvie
	# Goes through all menus.middlebury.edu meals for a given day, and creates an item for each 
	# 	meal if it doesn't already exist (based off meal name)
	def self.generate_items_from_meals(base_url, date_param="")
		menu_hash = MenuScraper.scrape_midd_menus(base_url, date_param)
		# puts menu_hash
		menu_hash.each do |time, time_hash|
			# puts time_hash
			time_hash.each do |hall, hall_array|
				# pp hall_array
				hall_array.each do |meal|
					if Item.find_by(name: meal).nil?
						Item.create(name: meal)
					end
				end
			end
		end
	end
end