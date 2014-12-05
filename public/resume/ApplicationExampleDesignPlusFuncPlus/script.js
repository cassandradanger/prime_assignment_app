$(document).ready(function () {
	var $container = $('#container');
	$container.hide();

	var $button = $('#button');
	$button.hide();
	$button.fadeIn("slow");

	var open = false;

	$button.click(function () {
		if(!open){
			$button.fadeOut("slow", function() {
				$container.slideDown("slow");
				open = true;
			});
		}
	});

	$container.click(function () {
		if(open){
			$container.slideUp("slow", function() {
				$button.fadeIn("slow");
				open = false;
			});
		}
	});
});