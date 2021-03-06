# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

items = %w{ Asparagus
                  Wheat_Bread
                  White_Bread
                  Tortilla
                  Relish
                  Ketchup
									Mustard
                  Dijon_Mustard
									Honey_Mustard
									Barbeque_Sauce
                  Mayonnaise
                  Swiss_Cheese
                  Cheddar_Cheese
                  American_Cheese
									Shredded_Cheese
									Parmesan_Cheese
									Cottage_Cheese
									Cream_Cheese
									Peanut_Butter
									Butter
									Rasin
									Brown_Sugar
									Rasberry_Jam
									Apricot_Jam
									Strawberry_Jam
									Grape_Jam
									English_Muffin
									Pita_Pocket
									Yogurt
									Strawberry_Yogurt
									Rasberry_Yogurt
									Blueberry_Yogurt
									Apple_Sauce
									Roast_Beef
									Tuna
									Turkey
									Ham
									Salami
									Refried_Beans
									Black_Beans
									Garabanzo_Beans
									Kidney_Beans
									Lima_Beans
									Pickles
									Salsa
									Sour_Cream
									Guacamole
									Potato_Chips
									Cumin
									Garlic
									Ginger
									Curry_Powder
									Crushed_Red_Pepper
									Cayenne
									Cajun_Seasoning
									Basil
									Nutritional_Yeast
									Oregano
									Cider_Vinegar
									Red_Italian_Vinegar
									Balsamic_Vinegar
									Franks_Hot_Sauce
									Sesame_Oil
									Olive_Oil
									Lemon_Juice
									Soy_Sauce
									Canola_Oil
									Sugar
									Cinnamon_Sugar
									Cinnamon
									Honey
									Herb_Dressing
									Green_Goddess_Dressing
									Thousand_Island
									Sesame_Dressing
									Italian_Herb_Dressing
									Creamy_Tarragon_Dressing
									Apple
									Orange
									Banana
									Grapefruit
									Grape_Nuts
									Special_K
									Total
									Granola
									Fruit_Loops
									Captain_Crunch
									Cheerios
									Rice_Krispies
									Raisin_Bran
									Frosted_Flakes
									Corn_Pops
									Lucky_Charms
									Life
									Pass-O-Gauva
									Lemonade
									Cranberry_Juice
									Orange_Juice
									Apple_Juice
									Soy_Milk
									Chocolate_Milk
									Skim_Milk
									2%_Milk
									Half_and_Half
									Whole_Milk
									Pepsi_Diet
									Pepsi
									Mountain_Dew
									Ginger_Ale
									Sierra_Mist
									Water
									Ice
									Brisk
									Root_Beer
									Club_Soda
									Hot_Cocoa
									Hazelnut_Cream_Coffee
									Coffee
									Green_Tea
									Green_Lemon_Tea
									Chamomile
									Cinnamon_Apple_Tea
									Darjeeling
									Mint_Tea
									Earl_Grey
									English_Teatime
									Constant_Comment
									Orange_and_Spice
									Lemon_Tea
									Lettuce
									Spinach
									Red_Onion
									Cucumber
									Tomato
									Green_Pepper
									Carrot
									Broccoli
									Celery
									Mushroom
									Tofu
									Black_Olive
									Corn
									Cole_Slaw
									Ham_Salad
									Cous_Cous
									Pasta_Salad_with_Tuna
									Quinoa_with_Mixed_Vegetables
									Sweet_and_Spicy_Beef
									Tuna_Salad
									Brown_Rice
									Sunflower_Seeds
									Soy_Nuts
									Croutons
									Oyster_Crackers
									Saltine_Crackers
									Ritz_Crackers
									Vegetable_Stock
									Vanilla_Soft_Serve
									Chocolate_Soft_Serve
									Twist_Soft_Serve
									Caramel_Syrup
									Rainbow_Sprinkles
									Chocolate_Sprinkles
									Chocolate_Syrup
									Sugar_Cone
									Cone
									Chocolate_Chips
									White_Chocolate_Chips
									Penne_Pasta
									Marinara_Sauce
									Alfredo_Sauce
									Marshmallows
									Lemon
									Spaghetti
									}
items.sort!

@a = ItemCategory.find_or_create_by(name: "Category 1")
@b = ItemCategory.find_or_create_by(name: "Category 2")

def rand_category
	if rand(10) >= 5
		@a
	else
		@b
	end
end

items.each do |item|
	name = item.gsub(/_/, " ")
	Item.find_or_create_by(name: name, item_category: rand_category)
end

tags = %w{ tasty yummy lunch dinner tangy sweet dessert }
a = TagCategory.find_or_create_by(name: "Tag Category 1")
tags.each do |tag|
	Tag.find_or_create_by(name: tag, tag_category: a)
end
