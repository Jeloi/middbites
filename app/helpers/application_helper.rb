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
end