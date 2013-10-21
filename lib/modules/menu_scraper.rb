require 'open-uri'

module MenuScraper
	
	def self.scrape_midd_menus(base_url, date_param="", sort_by="")

		url = (!date_param.blank? ? base_url + "/" + date_param : base_url) # append date_param if it isn't blank
		doc = Nokogiri::HTML(open(url))
		
		h2_nodes = doc.css(".content h2").to_ary.reject! {|node| node.text == "Grille"}	# filter out the Grille
		dining_halls = {}
		h2_nodes.each do |hall|
			dining_halls[hall.text] = hall.parent
		end
		
		# Build the nested hash, with dining hall being the top level key
		dining_halls.each do |key, node|
			meals = node.css(".meal")
			meal_times_hash = {}
			meals.each do |m|
				meal = []	# array to hold strings representing that meal
				meal_time = m.css("h3").text
				m.css("ul li a").each do |a|
					meal << a.text
				end
				meal_times_hash[meal_time] = meal
			end
			dining_halls[key] = meal_times_hash
		end
		
		# Transpose this hash so that meal time is the top level key
		meal_times = Hash.new{ |h,k| h[k] = {} }	# new hash, default values are empty hashes
		dining_halls.each_pair do |hall, meal_hash|
			meal_hash.each_pair do |meal_time, meal|
				meal_times[meal_time][hall] = meal
			end
		end

			
		if sort_by == "dining_hall"
			return dining_halls
		else	# sorted_by dining hall
			return meal_times
		end

	end


end