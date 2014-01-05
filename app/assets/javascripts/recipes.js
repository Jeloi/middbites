$(document).ready(function() {

	// "Load More" ajax functionality
	$('.recipe-listings').on('click', '#load_more', function(event) {
		event.preventDefault();
		url	= $('.pagination .next_page a').attr('href');
		$('#load_more').text('Loading...');
		setTimeout(5);
		$.getScript(url);
	});
	
});

$('.recipe-listings').ready(function() {
	// Show all invisible recipe items upon load
	$('.invisible').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}).removeClass('invisible');
});