// ...
//= require jquery
//= require jquery_ujs
//= require modernizr/modernizr
//= require bootstrap-sprockets
//= require_tree .

$('.nav-tabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})