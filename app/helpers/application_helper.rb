module ApplicationHelper

	# Helper method to return string "current" if params[:controller] equals given parameter
	def current?(path)
		"current" if current_page?(path)
	end

	# Returns content for dynamically generated nested form element
  def add_fields_helper(form_builder, association)
    new_object = form_builder.object.class.reflect_on_association(association).klass.new
    fields = form_builder.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
  end

  # Returns formatted link for items on ingredient pages
  def formatted_item_link(item)
    item_text = item.ingredients_count > 0 ? item.name+" (#{item.ingredients_count})" : item.name
    link_to item_text, item_path(item)
  end
end