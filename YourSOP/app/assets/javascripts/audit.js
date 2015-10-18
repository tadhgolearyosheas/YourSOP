$(document).ready(function () {
	$("#alert").hide();
	$("select[name$='][result]']").each(function() {
		$(this).change(function() {
			check_result();
		});
	});

	$("#status_filter_buttons input").click(function () {
        $(this).addClass("active btn-warning");
        $(this).siblings("input").each(function () {
        	$(this).removeClass("active btn-warning");
    	});
    });
});

function check_result() {
	var show = false;
	$("select").each(function() {
		if ($(this).val() == "3") {
			show = true;
		}
	});
	if (show) {
		$("#alert").show();
	}
	else {
		$("#alert").hide();
	}
}

