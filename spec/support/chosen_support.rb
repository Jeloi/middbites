module ChosenSelect
  def select_from_chosen(item_text, options)
    field = find_field(options[:from], visible: false)
    option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
    page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
    option_value = page.evaluate_script("value")
    pp option_value
    page.execute_script("$('##{field[:id]}').val(#{option_value})")
    page.execute_script("$('##{field[:id]}').trigger('chosen:updated').trigger('change')")
  end  

  def select_and_trigger_change(item_text, options)
    field = find_field(options[:from], visible: false)
    option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
    # page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
    # option_value = page.evaluate_script("value")
    page.execute_script("$('##{field[:id]}').val(#{option_value})")
    page.execute_script("$('##{field[:id]}').trigger('change')")
  end

  def tag_chosen_select(item_text, options)
    field = find_field(options[:from], visible: false)
    option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
    selected = option_value
    page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
    option_value = page.evaluate_script("value")
    pp selected
    page.execute_script("$('##{field[:id]}').val(#{option_value})")
    page.execute_script("$('##{field[:id]}').trigger('chosen:updated').trigger('change', {'selected':#{selected}})")
  end
end