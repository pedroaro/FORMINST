// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$('.eliminarN').click(function() {  
		console.log("eliminando");
		$(this).closest('tr').fadeOut();
	});  

});