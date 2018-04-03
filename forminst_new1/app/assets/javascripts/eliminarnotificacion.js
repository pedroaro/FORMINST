// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var deleteNotifications = function(){
	$('.eliminarN').click(function() {  
		console.log("eliminando");
		$(this).closest('tr').fadeOut();
	});  
}

$(document).ready(deleteNotifications);
$(document).on('turbolinks:load', deleteNotifications);
