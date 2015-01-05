// ...
//= require jquery
//= require jquery_ujs
//= require modernizr/modernizr
//= require bootstrap-sprockets
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require_tree .

$( document ).ready(function() {
  //  $('#admission-application-datatable').dataTable();
});



$('.nav-tabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})