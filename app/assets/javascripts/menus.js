
var id; // Global variable
var screen_width = $(window).width();
$(window).resize(function() {
    clearTimeout(id);
    id = setTimeout(
    	doneResizing, 800);
    
});

// Perform resize functionality after its done resizing
function doneResizing(){
	// if the width of the window changed only
	if ($(window).width() != screen_width) {
		screen_width = $(window).width();
	};
	console.log("Window Resized");
}

var menuSlider;
menuSlider = function() {
	var numSliders = $('#sliders_counter').data("numsliders");
	for (var i = 0; i < numSliders; i++) {
		var slider = '#bxslider' + i;
		var pager = '#bxpager' + i;
		$(slider).bxSlider({
			slideWidth: 320,
			minSlides: 1,
			maxSlides: 1,
			moveSlides: 1,
			infiniteLoop: false,
			controls: false,
			pagerCustom: pager,
			slideMargin: 10
		});
	};

};



$(document).ready(menuSlider);
$(document).on('page:load', menuSlider);