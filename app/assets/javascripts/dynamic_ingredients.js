
var id; // Global variable
$(window).resize(function() {
    clearTimeout(id);
    id = setTimeout(doneResizing, 800);
    
});

// Resize functionality after its done resizing
function doneResizing(){
	$('.ingredient-fields').css("transform","translateX("+0+"px)");
	console.log("Window Resized");
}



function resize_ingredient_text_fields() {
	var btn = 32;
	var wrap = $('#ingredients-section').width()
	var field_width = (wrap - 2*btn);
	$('#ingredients-section .ingredient-fields').width(wrap*2)
	$("#ingredients-section .ingredient-fields .name").width(field_width);
	$("#ingredients-section .ingredient-fields .quantity").width(field_width);
}

function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}



function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}