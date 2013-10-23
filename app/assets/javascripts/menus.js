
// Global Variable to hold slider objects, and their pages
var sliders_array = [];
var pager_array = [];

// screen width variables for number of slides
var oneSlide = 515;
var twoSlides = 800;
// var 3slides = 800;

// Initial Sliders set and stored in array. Respective pagers are stored in an array in same order.
menuSlider = function() {
	sliders_array = [];
	var numSliders = $('#sliders_counter').data("numsliders");
	if ($(window).width() < oneSlide) {
		for (var i = 0; i < numSliders; i++) {
			var slider = '#bxslider' + i;
			var pager = '#bxpager' + i;
			var slider_obj = $(slider).bxSlider({
				slideWidth: 1000,
				minSlides: 1,
				maxSlides: 1,
				moveSlides: 1,
				infiniteLoop: true,
				controls: false,
				pagerCustom: pager,
				slideMargin: 10
			});
			sliders_array.push(slider_obj); //add the slider_obj to the array
			pager_array.push(pager); //add the slider_obj to the array
		};
	} else if ($(window).width() < 800) {
		for (var i = 0; i < numSliders; i++) {
			var slider = '#bxslider' + i;
			var pager = '#bxpager' + i;
			var slider_obj = $(slider).bxSlider({
				slideWidth: 400,
				minSlides: 2,
				maxSlides: 2,
				moveSlides: 2,
				infiniteLoop: true,
				controls: false,
				pagerCustom: pager,
				slideMargin: 10
			});
			sliders_array.push(slider_obj); //add the slider_obj to the array
			pager_array.push(pager); //add the slider_obj to the array
		};
	} else {
		for (var i = 0; i < numSliders; i++) {
			var slider = '#bxslider' + i;
			var pager = '#bxpager' + i;
			var slider_obj = $(slider).bxSlider({
				slideWidth: 400,
				minSlides: 3,
				maxSlides: 3,
				moveSlides: 1,
				infiniteLoop: true,
				controls: false,
				pagerCustom: pager,
				slideMargin: 10
			});
			sliders_array.push(slider_obj); //add the slider_obj to the array
			pager_array.push(pager); //add the slider_obj to the array
		};
	}
};






var id; // Global variable
var screen_width = $(window).width();


// Perform resize functionality after its done resizing
function doneResizing(){
	// if the width of the window changed only
	if ($(window).width() != screen_width) {
		if ($(window).width() < oneSlide) {
			for (var i = 0; i < sliders_array.length; i++) {
				sliders_array[i].reloadSlider({
					slideWidth: 1000,
					minSlides: 1,
					maxSlides: 1,
					moveSlides: 1,
					infiniteLoop: true,
					controls: false,
					pagerCustom: pager_array[i],
					slideMargin: 10
				});
			}
		} else if ($(window).width() < twoSlides) {
			for (var i = 0; i < sliders_array.length; i++) {
				sliders_array[i].reloadSlider({
					slideWidth: 400,
					minSlides: 2,
					maxSlides: 2,
					moveSlides: 2,
					infiniteLoop: true,
					controls: false,
					pagerCustom: pager_array[i],
					slideMargin: 10
				});
			}
		} else {
			for (var i = 0; i < sliders_array.length; i++) {
				sliders_array[i].reloadSlider({
					slideWidth: 400,
					minSlides: 3,
					maxSlides: 3,
					moveSlides: 1,
					infiniteLoop: true,
					controls: false,
					pagerCustom: pager_array[i],
					slideMargin: 10
				});
			}
		}
		screen_width = $(window).width();
	};
}

// Listeners
$(document).ready(menuSlider);
$(document).on('page:load', menuSlider);	// for turbolinks
$(window).resize(function() {
    clearTimeout(id);
    id = setTimeout(
    	doneResizing, 800);
    
});