// Foundation
$(function(){ 
	$(document).foundation();

	// Search reveal
	$(document).foundation('reveal', {
		animation: 'fade',
		animation_speed: 100,
		close_on_background_click: true
	});

	$('.flash .fa-times').click(function(event) {
		$(this).closest('.flash').fadeOut('400');
	});

});

// Search modal effects
$(document).on('opened', '#search-modal', function(event) {
	$('#search-modal #search').focus();
	$('.search-button').addClass('active fa fa-times');
});
$(document).on('closed', '#search-modal', function () {
	$('.search-button').removeClass('active fa fa-times');
});
// Sign in modal
$(document).on('opened', '#sign_in_modal', function(event) {
	$('input#user_username').focus();
});

// Spinner for turbolinks effect
$(document).on('page:fetch', function() {
$('.main-content').fadeOut('fast');
$('#spinner').fadeIn('slow');
});
$(document).on('page:change', function() {
$('#spinner').hide();
$('.main-content').fadeIn('fast');
});






$(function () {
	$('input[data-tooltip]').on('focus', function(event) {
		$(this).mouseenter();
	}).on('blur', function(event) {
		$(this).mouseout();
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

	// Search modal close button
	$('.search-button').click(function(event) {
		$('#search-modal').foundation('reveal', 'close');
	});

	// Sign in modal close button
	$('#sign_in_modal a.close').click(function(event) {
		$('#sign_in_modal').foundation('reveal', 'close');
	});

});

// jQuery(document).ready(function($) {
// 	// our function that decides weather the navigation bar should have "fixed" css position or not.
// 	var sticky_navigation = function(){
// 	    var scroll_top = $(window).scrollTop(); // our current vertical position from the top
// 		// Sticky Navigation
// 		// grab the initial top offset of the navigation 
// 		var sticky_navigation_offset_top = $('#sticky_navigation').offset().top;
	     
// 	    // if we've scrolled more than the navigation, change its position to fixed to stick to top,
// 	    // otherwise change it back to relative
// 	    if (scroll_top > sticky_navigation_offset_top) { 
// 	        // $('#sticky_navigation').css({ 'position': 'fixed', 'top':0, 'left':0 });
// 	        $('#sticky_navigation').addClass('fixed');
// 	        $('.fixed-appear').fadeIn('400');
// 	    } else {
// 	        $('#sticky_navigation').removeClass('fixed');
// 	        // $('#sticky_navigation').css({ 'position': 'relative' }); 
// 	        $('.fixed-appear').hide();
// 	    }   
// 	};
// 	// run our function on load
// 	sticky_navigation();
	
//   // and run it again every time you scroll
//   $(document).scroll(function() {
//        sticky_navigation();
//   });
// });
 


// console.log("something");


