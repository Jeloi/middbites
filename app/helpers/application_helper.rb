module ApplicationHelper
  def add_fields_helper(form_builder, association)
    new_object = form_builder.object.class.reflect_on_association(association).klass.new
    fields = form_builder.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    # link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end