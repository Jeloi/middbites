$(document).ready(function() {

	// "Load More" ajax functionality
	$('.recipe-listings').on('click', '#load_more', function(event) {
		event.preventDefault();
		url	= $('.pagination .next_page a').attr('href');
		$('#load_more').text('Loading...');
		setTimeout(5);
		$.getScript(url);
	});


	// Hover shows ingredients list
	$('.ingredients-hover').hover(function() {
		$(this).closest('.recipe-item').find('.overlay.ingredient-list').css('opacity', '1');	
	}, function() {
		$(this).closest('.recipe-item').find('.overlay.ingredient-list').css('opacity', '0');
	});
	// Hover shows tags list
	$('.tags-hover').hover(function() {
		$(this).closest('.recipe-item').find('.overlay.main').css('opacity', '1');	
	}, function() {
		$(this).closest('.recipe-item').find('.overlay.main').css('opacity', '0');
	});


	// Show recipe, make other share-links inactive on hover
	$('.share-links span').hover(function() {
		$('.share-links span').not(this).addClass('inactive');
	}, function() {
		$('.share-links span').not(this).removeClass('inactive');
	});
	
});

$('.recipe-listings').ready(function() {
	// Show all invisible recipe items upon load
	$('.invisible').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}).removeClass('invisible');
});