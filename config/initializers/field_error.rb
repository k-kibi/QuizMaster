ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  class_attr = 'class="'
  class_attr_index = html_tag.index class_attr

  if class_attr_index
    html_tag.insert class_attr_index + class_attr.size, 'is-invalid '
  else
    html_tag.insert html_tag.index('>'), ' class="is-invalid"'
  end
end
