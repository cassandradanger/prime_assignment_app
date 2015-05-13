module ApplicationHelper
  def admission_application_workflow_button_list app
    rtn = ''
    groups = Hash.new
    if app.current_state.events.count > 0
      app.current_state.events.keys.each do |key|
        if app.current_state.events[key][0].meta.count > 0
          if app.current_state.events[key][0].meta[:group].nil?
            rtn += link_to(AdmissionApplication.workflow_state_name(app.current_state.events[key][0].transitions_to), workflow_admission_application_path(app, workflow_action: key), method: :patch, class: 'btn btn-sm m-r-sm ' + app.current_state.events[key][0].meta[:btn_class])
          else
            if groups[app.current_state.events[key][0].meta[:group]].nil?
              groups[app.current_state.events[key][0].meta[:group]] = Array.new
            end
            groups[app.current_state.events[key][0].meta[:group]].push(key)
          end
        end
      end
      if !groups.nil? then
        groups.each do |key, value|
          rtn += admission_application_workflow_split_button(app, key, value)
        end
      end
    end
    if rtn != ''
      rtn = content_tag(:dl, content_tag(:dt,'Update Status',{class: 'm-b-sm'}) + content_tag(:dd, rtn.html_safe))
    end
    rtn.html_safe
  end

  def admission_application_workflow_split_button(app, key, list)
    btn_group = ''
    ul_content = ''
    first_item = list.shift
    list.each do |item|
      link = link_to(AdmissionApplication.workflow_state_name(app.current_state.events[item][0].transitions_to), workflow_admission_application_path(app, workflow_action: item), method: :patch)
      ul_content += content_tag(:li, link)
    end
    ul_content = content_tag(:ul, ul_content.html_safe, {class: 'dropdown-menu', rold: 'menu'})
    btn_group = link_to(AdmissionApplication.workflow_state_name(app.current_state.events[first_item][0].transitions_to), workflow_admission_application_path(app, workflow_action: first_item), method: :patch, class: 'btn btn-sm ' + app.current_state.events[first_item][0].meta[:btn_class])
    btn_group += content_tag(:button,
                             content_tag(:span, '', {class: 'caret'}) + content_tag(:span, 'Toggle Dropdown', {class: 'sr-only'}),
                             {class: 'btn btn-sm '+ app.current_state.events[first_item][0].meta[:btn_class] + ' dropdown-toggle', data: {toggle: 'dropdown'}})
    content_tag(:div, btn_group + ul_content, {class: 'btn-group m-r-sm '})
  end
end
