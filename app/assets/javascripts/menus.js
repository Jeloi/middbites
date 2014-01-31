// // Global Variable to hold slider objects, and their pages
var sliders_array;
var pager_array;


// // screen width variables for number of slides
var oneSlide = 600;
var twoSlides = 930;
// // var 3slides = 800;

// // Initial Sliders set and stored in array. Respective pagers are stored in an array in same order.
initializeSliders = function() {
	// Initialize the arrays
	sliders_array = [];
	pager_array = [];
	var numSliders = $('#menu-tabs').data("numsliders");
	if ($(window).width() < oneSlide) {
		for (var i = 0; i < numSliders; i++) {
			var slider = '#bxslider' + i;
			var pager = '#bxpager' + i;
			var slider_obj = $(slider).bxSlider({
				slideWidth: 1000,
				minSlides: 1,
				maxSlides: 1,
				moveSlides: 1,
				// infiniteLoop: true,
				controls: false,
				pagerCustom: pager,
				mode: "vertical",
				// slideMargin: 10,
				touchEnabled: false,
				// adaptiveHeight: true
			});
			sliders_array.push(slider_obj); //add the slider_obj to the array
			pager_array.push(pager); //add the slider_obj to the array
		};
	} else if ($(window).width() < twoSlides) {
		for (var i = 0; i < numSliders; i++) {
			var slider = '#bxslider' + i;
			var pager = '#bxpager' + i;
			var slider_obj = $(slider).bxSlider({
				slideWidth: 1000,
				minSlides: 2,
				maxSlides: 2,
				moveSlides: 1,
				// infiniteLoop: true,
				controls: false,
				pagerCustom: pager,
				mode: "horizontal",
				// slideMargin: 10,
				touchEnabled: false,
				// adaptiveHeight: true
			});
			sliders_array.push(slider_obj); //add the slider_obj to the array
			pager_array.push(pager); //add the slider_obj to the array
		};
	} else {
		for (var i = 0; i < numSliders; i++) {
			var slider = '#bxslider' + i;
			var pager = '#bxpager' + i;
			var slider_obj = $(slider).bxSlider({
				slideWidth: 1000,
				minSlides: 3,
				maxSlides: 3,
				moveSlides: 1,
				// infiniteLoop: true,
				controls: false,
				pagerCustom: pager,
				mode: "horizontal",
				// slideMargin: 10,
				touchEnabled: false,
				// adaptiveHeight: true
			});
			sliders_array.push(slider_obj); //add the slider_obj to the array
			pager_array.push(pager); //add the slider_obj to the array
		};
	}
};


function reloadSlider (i) {
	if ($(window).width() < oneSlide) {
		sliders_array[i].reloadSlider({
			slideWidth: 1000,
			minSlides: 1,
			maxSlides: 1,
			moveSlides: 1,
				// infiniteLoop: true,
				controls: false,
				pagerCustom: pager_array[i],
				mode: "vertical",
				// slideMargin: 10,
				touchEnabled: false,
				// adaptiveHeight: true
			});
	} else if ($(window).width() < twoSlides) {
		sliders_array[i].reloadSlider({
			slideWidth: 1000,
			minSlides: 2,
			maxSlides: 2,
			moveSlides: 1,
				// infiniteLoop: true,
				controls: false,
				pagerCustom: pager_array[i],
				mode: "horizontal",
				// slideMargin: 10,
				touchEnabled: false,
				// adaptiveHeight: true
			});
	} else {
		sliders_array[i].reloadSlider({
			slideWidth: 1000,
			minSlides: 3,
			maxSlides: 3,
			moveSlides: 1,
				// infiniteLoop: true,
				controls: false,
				pagerCustom: pager_array[i],
				mode: "horizontal",
				// slideMargin: 10,
				touchEnabled: false,
				// adaptiveHeight: true
			});
	}
}

var id; // Global variable
var screen_width = $(window).width();
// Perform resize functionality after its done resizing
function doneResizing(){
	// if the width of the window changed only
	if ($(window).width() != screen_width) {

		if ($('#menu-tab-content').length) {
			// Find tab's slider index and reload slider
			var i = $('#menu-tab-content .content.active').data('index');
			reloadSlider(i);
		};

		screen_width = $(window).width();
	};
}

// // Listeners
$(document).ready(initializeSliders);
// $(window).load(initializeSliders);
// $(document).on('page:load', initializeSliders);	// for turbolinks
$(window).resize(function() {
    clearTimeout(id);
    id = setTimeout(
    	doneResizing, 800);
    
});


$(document).ready(function() {
	$('#menu-tabs').on('toggled', function (event, tab) {
		var i = tab.data('index');
		reloadSlider(i);
	});
	
});