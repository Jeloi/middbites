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
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require bxslider/jquery.bxslider
//= require chosen-jquery
// require pushy.min
// require modernizr-2.6.2.min
//= require_tree .

// Foundation
$(function(){ 
	$(document).foundation();

	// Search reveal
	$(document).foundation('reveal', {
		animation: 'fade',
		animation_speed: 100,
		close_on_background_click: true
	});
	$(document).on('opened', '#search-modal', function(event) {
		$('#search-modal #search').focus();
		$('.search-button').addClass('active fi-x');
	});
	$(document).on('closed', '#search-modal', function () {
		$('.search-button').removeClass('active fi-x');
	});
	$('.search-button').click(function(event) {
		$('#search-modal').foundation('reveal', 'close');
	});
	
});



$(function () {

	// Sticky Navigation
	// grab the initial top offset of the navigation 
	// var sticky_navigation_offset_top = $('#sticky_navigation').offset().top;
	 
	// // our function that decides weather the navigation bar should have "fixed" css position or not.
	// var sticky_navigation = function(){
	//     var scroll_top = $(window).scrollTop(); // our current vertical position from the top
	     
	//     // if we've scrolled more than the navigation, change its position to fixed to stick to top,
	//     // otherwise change it back to relative
	//     if (scroll_top > sticky_navigation_offset_top) { 
	//         // $('#sticky_navigation').css({ 'position': 'fixed', 'top':0, 'left':0 });
	//         $('#sticky_navigation').addClass('fixed');
	//         $('.fixed-appear').fadeIn('400');
	//     } else {
	//         $('#sticky_navigation').removeClass('fixed');
	//         // $('#sticky_navigation').css({ 'position': 'relative' }); 
	//         $('.fixed-appear').hide();
	//     }   
	// };
	 
	// run our function on load
	sticky_navigation();
	 
	// and run it again every time you scroll
	$(window).scroll(function() {
	     sticky_navigation();
	});
	

	//Off-canvas menu
	$("#secondHeader .menu-button").on('touchstart click', function(e) {
	   e.preventDefault();
	   $("#page, #secondHeader").toggleClass("pageOpen");
	   $("#headerWrapper").toggleClass("headerOpen");
	   $(this).toggleClass("menu-button-active");
	   // Close search if its open
	   $('#search-modal').foundation('reveal', 'close');
	   // $('#secondHeader .logo').fadeToggle('fast');
	});
	// Close canvas when touching the page wrap
	$('.offcanvas-wrap').on('touchstart click', function() {
	   $("#page, #secondHeader").removeClass("pageOpen");
	   $('#headerWrapper').removeClass('headerOpen');
	   $('#secondHeader .menu-button').toggleClass("menu-button-active");
	});

	//Hide search modal, didn't work
	$('.reveal-modal-bg').on('touchstart click', function() {
	   $('#search-modal').foundation('reveal', 'close');
	});

	// Back to top scrolling
	$('a.back-to-top').click(function (e) {
		e.preventDefault();
		$('html,body').animate({
		scrollTop: 0}, 500);
		return	false;
	});

});
