define(function(require, exports, module) { // jshint ignore:line
    'use strict';
    
    var Modernizr = require('modernizr');
    var jQuery = require('jquery');
    var jQueryUjs = require('jquery-ujs');
    var Waypoints = require('waypoints');

    /**
     * Initial application setup. Runs once upon every page load.
     *
     * @class App
     * @constructor
     */
    var App = function() {
        this.init();
        
        $('.section-masthead-logo').waypoint(
            {
              handler: function(direction) {
                if(direction=="up") {
                    $('.layout-header').removeClass("layout-header-fixed");
                } else {
                    $('.layout-header').addClass("layout-header-fixed");                    
                }
              }, offset: -45
            }
        );

       $('.section-masthead-logo').waypoint(
            {
              handler: function(direction) {
                if(direction=="up") {
                    $('.section-masthead-logo').removeClass("section-masthead-logo-hidden");
                } else {
                    $('.section-masthead-logo').addClass("section-masthead-logo-hidden");                   
                }
              }, offset: -108
            }
        );


        $('.navigation-button').click(
            function() {
                $('.navigation-menu').toggleClass('navigation-menu_open');
            }
        );

        $('.slider-link').click(
            function(event) {
                event.preventDefault();
                $('.navigation-menu').toggleClass('navigation-menu_open');
                $('html, body').animate({
                    scrollTop: $(event.target.hash).offset().top-60
                }, 1000);                
            }
        );

        // $(window).scroll(function() {
        //     var speed = 8.0;
        //     $('.section-network').css("background-position", "100% " + (-window.pageYOffset / speed) + "px");
        // });

    }


    var proto = App.prototype;

    /**
     * Initializes the application and kicks off loading of prerequisites.
     *
     * @method init
     * @private
     */
    proto.init = function() {
        // Create your views here
    };

    return App;

});