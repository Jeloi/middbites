desc "Create Recipe Records"
task :generate_records => :environment do
	num = ENV['num'].to_i || 16
	num.times do
		FactoryGirl.create(:multiple_recipes, :with_ingredients, :with_taggings)
	end
end