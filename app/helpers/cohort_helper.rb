module CohortHelper
  def cohort_status_label status
      text_style = 'label-primary'
      case status
        when 'Pre-Application', 'Completed'
          text_style = 'label-default'
        when 'Prework', 'Classroom'
          text_style = 'label-success'
        when 'Applications Closed'
          text_style = 'label-info'
      end
      content_tag(:span, status, class: "label #{text_style}")
  end

  def cohort_full_label cohort
    "#{cohort.classroom_start.to_formatted_s(:long)} - #{cohort.graduation.to_formatted_s(:long)}"
  end

  def cohort_next_action_label cohort
    label_txt = ''
    case
      when Date.today <= cohort.applications_open
        label_txt = "Applications open in #{time_ago_in_words(cohort.applications_open)}"
      when Date.today <= cohort.applications_close
        label_txt = "Applications close in #{time_ago_in_words(cohort.applications_close)}"
      when Date.today <= cohort.prework_start
        label_txt = "Prework start in #{time_ago_in_words(cohort.prework_start)}"
      when Date.today <= cohort.classroom_start
        label_txt = "Classroom starts in #{time_ago_in_words(cohort.classroom_start)}"
      when Date.today <= cohort.graduation
        label_txt = "Classroom ends in #{time_ago_in_words(cohort.graduation)}"
      else
        label_txt = "Classroom ended #{time_ago_in_words(cohort.graduation)} ago"
    end
  end
end