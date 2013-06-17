json.array!(@recipes) do |recipe|
  json.extract! recipe, :directions, :references, :references
  json.url recipe_url(recipe, format: :json)
end