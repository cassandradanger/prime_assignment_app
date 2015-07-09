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
    stateSave: false,
    processing: true,
    serverSide: true,
    ajax: $('#admission-application-datatable').data('source'),
    columnDefs: [
      orderable: false, targets: [4,5,6,7,8,9]
    ]

  $('#app_status_admission_application_application_status').change (e) ->
    updateAssignedCohortDiv()

  updateAssignedCohortDiv = ->
    status = $('#app_status_admission_application_application_status').val()
    if status == 'placed' or status == 'confirmed'
      $('#assigned_cohort').removeClass('hidden')
    else
      $('#assigned_cohort').addClass('hidden')

  $('[data-toggle="tooltip"]').tooltip()

  $('ul.audit-change-list').each ->
    LiN = $(this).find('li').length
    if( LiN > 3)
      $('li', this).eq(2).nextAll().hide().addClass('toggleable')
      $(this).append('<li><a href="#" class="more">More...</a></li>');

  $('ul.audit-change-list').on 'click','.more', (e) ->
    e.preventDefault()
    if( $(this).hasClass('less') )
      $(this).text('More...').removeClass('less')
    else
      $(this).text('Less...').addClass('less')
    $(this).parent().siblings('li.toggleable').slideToggle()









