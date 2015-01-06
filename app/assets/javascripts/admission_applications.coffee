$(document).ready ->
  $('#admission-application-datatable').dataTable
    autoWidth: true,
    pagingType: 'full_numbers',
    searching: false,
    pageLength: 50,
    lengthChange: false,
    stateSave: true,
    columnDefs: [
      orderable: false, targets: [7]
    ]


