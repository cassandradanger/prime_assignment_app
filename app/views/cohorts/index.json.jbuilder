json.array!(@cohorts) do |cohort|
  json.extract! cohort, :id, :prework_start, :classroom_start, :graduation, :applications_open, :applications_close
  json.url cohort_url(cohort, format: :json)
end
