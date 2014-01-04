// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require bxslider/jquery.bxslider
//= require chosen-jquery
//= require pushy/js/pushy.min.js
//= require pushy/js/vendor/modernizr-2.6.2.min.js
//= require_tree .

// $(function(){ $(document).foundation(); });

// var id; // Global variable
// var screen_width = $(window).width();
// $(window).resize(function() {
//     clearTimeout(id);
//     id = setTimeout(
//     	doneResizing, 800);
    
// });

// // Resize functionality after its done resizing
// function doneResizing(){
// 	// if the width of the window changed only
// 	if ($(window).width() != screen_width) {
// 		$('.ingredient-fields').css("transform","translateX("+0+"px)");
// 		screen_width = $(window).width();
// 	};
// 	console.log("Window Resized");
// }
$(function(){ $(document).foundation(); });

$(function () {

	// Sticky Navigation
	// grab the initial top offset of the navigation 
	var sticky_navigation_offset_top = $('#sticky_navigation').offset().top;
	 
	// our function that decides weather the navigation bar should have "fixed" css position or not.
	var sticky_navigation = function(){
	    var scroll_top = $(window).scrollTop(); // our current vertical position from the top
	     
	    // if we've scrolled more than the navigation, change its position to fixed to stick to top,
	    // otherwise change it back to relative
	    if (scroll_top > sticky_navigation_offset_top) { 
	        $('#sticky_navigation').css({ 'position': 'fixed', 'top':0, 'left':0 });
	        $('.fixed-appear').fadeIn('400');
	    } else {
	        $('#sticky_navigation').css({ 'position': 'relative' }); 
	        $('.fixed-appear').hide();
	    }   
	};
	 
	// run our function on load
	sticky_navigation();
	 
	// and run it again every time you scroll
	$(window).scroll(function() {
	     sticky_navigation();
	});

	// Vertically Center Content
	function verticalCenter() {
		if ($(window).width() >= 500) {
			$('.vert-align').each(function() {
				var $itemHeight = $(this).parent().outerHeight();
				var $itemTitleHeight = $(this).outerHeight();
				var $marginTop = ($itemHeight - $itemTitleHeight) / 2;
				$(this).css('margin-top', $marginTop + "px");
			});
		} else {
			$('.vert-align').css('margin-top', "0px");
		};
	}

	if($('.recipe-item').length) {
		verticalCenter();
		$(window).on('load resize facetwp-loaded', verticalCenter);
	}
});
