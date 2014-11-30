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
                    $('.section-masthead-logo').removeClass("section-masthead-logo-hidden");                    
                } else {
                    $('.layout-header').addClass("layout-header-fixed");                    
                    $('.section-masthead-logo').addClass("section-masthead-logo-hidden");                                       
                }
              }, offset: -45
            }
        );

       // $('.section-masthead-logo').waypoint(
       //      {
       //        handler: function(direction) {
       //          if(direction=="up") {
       //              $('.section-masthead-logo').removeClass("section-masthead-logo-hidden");
       //          } else {
       //              $('.section-masthead-logo').addClass("section-masthead-logo-hidden");                   
       //          }
       //        }, offset: -108
       //      }
       //  );


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
                }, 1000);                
            }
        );

        $(window).scroll(function() {
            var speed = 10.0;
            $('.difference-item-inside').css("background-position-y", ($('.difference-item-inside')[0].getBoundingClientRect().top / speed) + "px");               
            $('.difference-item-experts').css("background-position-y", ($('.difference-item-experts')[0].getBoundingClientRect().top / speed) + "px");
            $('.difference-item-doing').css("background-position-y", ($('.difference-item-doing')[0].getBoundingClientRect().top / speed) + "px");       
            $('.difference-item-apprenticeship').css("background-position-y", ($('.difference-item-apprenticeship')[0].getBoundingClientRect().top / speed) + "px");       
        });

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