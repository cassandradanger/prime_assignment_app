$(document).ready ->

  $('#admission-application-index-tabs a').click (e) ->
    e.preventDefault
    $.cookie('admission_application_index_active_tab', $(e.target).attr("href").substr(1), { expires : 10 })
    $(this).tab('show')

#  initializeTabs = ->
#    hash = 'general'
#    if $.cookie('admission-application-index-active-tab').length
#      hash = $.cookie('admission-application-index-active-tab')
#
#    $('#admission-application-index-tabs a[href="#' + hash + '"]').tab('show')
#
#  initializeTabs()

  $('#admission-application-datatable').dataTable
    autoWidth: true,
    pagingType: 'full_numbers',
    pageLength: 50,
    lengthChange: false,
    stateSave: true,
    columnDefs: [
      orderable: false, targets: [8]
    ]

  $('#app_status_admission_application_application_status').change (e) ->
    updateAssignedCohortDiv()

  updateAssignedCohortDiv = ->
    if $('#app_status_admission_application_application_status').val() == 'placed'
      $('#assigned_cohort').removeClass('hidden')
    else
      $('#assigned_cohort').addClass('hidden')





