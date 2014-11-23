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
            function(direction) {
                if(direction=="up") {
                    $('.layout-header').removeClass("layout-header-fixed")
                    console.log("going up");
                } else {
                    $('.layout-header').addClass("layout-header-fixed")                    
                    console.log("going down");
                }
            }, { offset: -20});
        };

        $('.navigation-button').click(
            function() {
                $('.navigation-menu').toggleClass('navigation-menu_open');
            }
        );

        $('.navigation-menu-item-link').click(
            function() {
                $('.navigation-menu').toggleClass('navigation-menu_open');
            }
        );


        // $(window).scroll(function() {
        //     var speed = 5.0;
        //     $('#intro').css("background-position", "50% " + (-window.pageYOffset / speed) + "px");
        // });

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