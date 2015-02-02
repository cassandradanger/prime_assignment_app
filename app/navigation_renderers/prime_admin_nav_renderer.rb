# Renders an ItemContainer as a list of <li> elements.
# It adds the 'selected' class to li element AND the link inside the li
# element that is currently active.
#
# If the sub navigation should be included (based on the level and
# expand_all options), it renders another <ul> containing the sub navigation
# inside the active <li> element.
#
# By default, the renderer sets the item's key as dom_id for the rendered
# <li> element unless the config option <tt>autogenerate_item_ids</tt> is
# set to false.
# The id can also be explicitely specified by setting the id in the
# html-options of the 'item' method in the config/navigation.rb file.
class PrimeAdminNavRenderer < SimpleNavigation::Renderer::Base
  def render(item_container)
    if skip_if_empty? && item_container.empty?
      ''
    else
      if item_container.level > 1
        tag = options[:ordered] ? :ol : :ul
        content = list_content(item_container)
        content.html_safe
        content_tag(tag, content, item_container.dom_attributes)
      else
        content = list_content(item_container)
        content.html_safe
      end

    end
  end

  private

  def list_content(item_container)
    item_container.items.map { |item|
      li_options = item.html_options.except(:link)
      if include_sub_navigation?(item)
        li_content = li_header(item)
      elsif item.html_options[:opts]
        li_content = li_icon(item)
      else
        li_content = tag_for(item)
      end
      if include_sub_navigation?(item)
        li_content << self.render_sub_navigation_for(item)
      end
      content_tag(:li, li_content, li_options.except(:opts))
    }.join
  end

  def li_icon(item)
    icon = nil
    if item.html_options[:opts] && item.html_options[:opts][:icon]
      icon = content_tag(:i, nil, {class: item.html_options[:opts][:icon]})
    end
    content_tag(:a, icon + content_tag(:span, item.name, {class: 'nav-label'}), {:href => item.url, :method => item.method}.merge(item.html_options.except(:class, :id, :opts)))
  end

  def li_header(item)
    icon = nil
    if item.html_options[:opts] && item.html_options[:opts][:icon]
      icon = content_tag(:i, nil, {class: item.html_options[:opts][:icon]})
    end
    content_tag(:a,icon + content_tag(:span, item.name, {class: 'nav-label'}) + content_tag(:span, nil, class: 'fa arrow'), {:href => item.url, :method => item.method}.merge(item.html_options.except(:class, :id, :opts)))
  end

end
