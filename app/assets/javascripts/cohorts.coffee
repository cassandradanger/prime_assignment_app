$(document).ready ->
  $('.datepicker').datepicker
    format: "yyyy-mm-dd"

  $('#cohort-admission-application-datatable').dataTable
    autoWidth: true,
    pagingType: 'full_numbers',
    searching: true,
    pageLength: 50,
    lengthChange: false,
    stateSave: true,
    columnDefs: [
      orderable: false, targets: [7]
    ]

