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
    searching: false,
    pageLength: 50,
    lengthChange: false,
    stateSave: true,
    columnDefs: [
      orderable: false, targets: [8]
    ]




