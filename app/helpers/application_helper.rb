module ApplicationHelper
  def full_title page_title = ""
    base_title = t(:base_title)
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "#", onclick: "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to name, "#", onclick: "add_fields(this, \"#{association}\",
      \"#{escape_javascript(fields)}\")", class: "btn btn-default btn-block"
  end

  def markdown_parse str
    bc = BlueCloth.new str, pandoc_headers: true
    simple_format bc.to_html
  end
end
