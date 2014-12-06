// ...
//= require jquery
//= require jquery_ujs
//= require modernizr/modernizr
//= require jquery-waypoints/waypoints
//= require litebox/litebox

$('.section-masthead-logo').waypoint(
    {
      handler: function(direction) {
        if(direction=="up") {
            $('.layout-header').removeClass("layout-header-fixed");
            $('.section-masthead-logo').removeClass("section-masthead-logo-hidden");                    
        } else {
            $('.layout-header').addClass("layout-header-fixed");                    
            $('.section-masthead-logo').addClass("section-masthead-logo-hidden");                                       
        }
      }, offset: -25
    }
);

$('#program').waypoint(
    {
      handler: function(direction) {
        $(".navigation-menu-item-link").removeClass("current");
        $(".navigation-menu-item-link-program").addClass("current");
      }, offset: 60
    }
);

$('#curriculum').waypoint(
    {
      handler: function(direction) {
        $(".navigation-menu-item-link").removeClass("current");
        $(".navigation-menu-item-link-curriculum").addClass("current");
      }, offset: 60
    }
);

$('#tuition').waypoint(
    {
      handler: function(direction) {
        $(".navigation-menu-item-link").removeClass("current");
        $(".navigation-menu-item-link-tuition").addClass("current");
      }, offset: 60
    }
);

$('#network').waypoint(
    {
      handler: function(direction) {
        $(".navigation-menu-item-link").removeClass("current");
        $(".navigation-menu-item-link-network").addClass("current");
      }, offset: 60
    }
);

$('#about').waypoint(
    {
      handler: function(direction) {
        $(".navigation-menu-item-link").removeClass("current");
        $(".navigation-menu-item-link-about").addClass("current");
      }, offset: 60
    }
);

$('#intro').waypoint(
    {
      handler: function(direction) {
        $(".navigation-menu-item-link").removeClass("current");
      }, offset: 60
    }
);

$('.navigation-button').click(
    function() {
        $('body').toggleClass('menu-open');
    }
);

$('.slider-link').click(
    function(event) {
        event.preventDefault();
        $('body').toggleClass('menu-open');
        $('html, body').animate({
            scrollTop: $(event.target.hash).offset().top-60
        }, 1000, function(){$('.navigation-menu-item-link').removeClass("current");$(event.target).addClass("current");});                
    }
);

$(window).scroll(function() {
    var speed = 10.0;
    $('.difference-item-inside').css("background-position-y", ($('.difference-item-inside')[0].getBoundingClientRect().top / speed) + "px");               
    $('.difference-item-experts').css("background-position-y", ($('.difference-item-experts')[0].getBoundingClientRect().top / speed) + "px");
    $('.difference-item-doing').css("background-position-y", ($('.difference-item-doing')[0].getBoundingClientRect().top / speed) + "px");       
    $('.difference-item-apprenticeship').css("background-position-y", ($('.difference-item-apprenticeship')[0].getBoundingClientRect().top / speed) + "px");       
    $('.video-header-video').css("top", -($(window).scrollTop() / 5) + "px");       
});


$('.litebox').liteBox({
  revealSpeed: 400,
  background: 'rgba(0,0,0,.8)',
  overlayClose: true,
  escKey: true,
  navKey: true,
  callbackInit: function() {},
  callbackBeforeOpen: function() {},
  callbackAfterOpen: function() {},
  callbackBeforeClose: function() {},
  callbackAfterClose: function() {},
  callbackError: function() {},
  callbackPrev: function() {},
  callbackNext: function() {},
  errorMessage: 'Error loading content.'
});