$(document).ready(function() {

	// "Load More" ajax functionality
	$('.recipe-listings').on('click', '#load_more', function(event) {
		event.preventDefault();
		url	= $('.pagination .next_page a').attr('href');
		$('#load_more').text('Loading...')
		$.getScript(url);
	});
	
});