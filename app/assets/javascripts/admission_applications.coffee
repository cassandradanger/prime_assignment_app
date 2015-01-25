$(document).ready ->
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

  $('.chosen-select').chosen
    allow_single_deselect: true

