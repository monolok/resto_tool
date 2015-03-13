// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


// $('.modal').click(function () {

// })
$(function () {
  	$('[data-toggle="tooltip"]').tooltip()
	
	$('#concept_start').click(function (event) {
		$('html, body').animate({
			scrollTop: $('#concept').offset().top
			}, 1500);
	event.preventDefault();
	});

	$('#functioning_start').click(function (event) {
		$('html, body').animate({
			scrollTop: $('#functioning').offset().top
			}, 1500);
	event.preventDefault();
	});

	$('#pricing_start').click(function (event) {
		$('html, body').animate({
			scrollTop: $('#pricing').offset().top
			}, 1500);
	event.preventDefault();
	});
})

function myFace() {
window.open("https://www.facebook.com/sharer/sharer.php?app_id=209034415775655&sdk=joey&u=https%3A%2F%2Fwww.restool.herokuapp.com/%2F&display=popup&ref=plugin", "_blank", "toolbar=no, scrollbars=no, resizable=no, top=150, left=400, width=500, height=500");
}