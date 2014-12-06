$(document).ready(function () {
	var $container = $('#container');
	$container.hide();

	var $button = $('#button');
	$button.click(function () {
		$container.show();
		$button.hide();
	});
});