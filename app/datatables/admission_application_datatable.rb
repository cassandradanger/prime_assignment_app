class AdmissionApplicationDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator

  def_delegators :@view, :link_to, :html_safe, :admission_application_path

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= %w(User.email AdmissionApplication.last_name AdmissionApplication.application_status AdmissionApplication.application_status_updated_at)
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= %w(User.email AdmissionApplication.last_name AdmissionApplication.first_name)
  end

  private

  def data
    records.map do |record|
      [
          record.user.email,
          record.name,
          record.application_status_name,
          record.days_since_status_update,
          record.assigned_cohort_name,
          record.logic_questions_score,
          record.profile_questions_score,
          record.resume_score,
          record.interview_score_name,
          link_to("View".html_safe, admission_application_path(record))
      ]
    end
  end

  # record.user.email,
  #     record.name,


  def get_raw_records
    AdmissionApplication.filter(options.slice(:cohort,:assigned_cohort,:app_status)).includes(:user).references(:user)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
