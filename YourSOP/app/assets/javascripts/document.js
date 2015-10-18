$(document).ready(function () {

   //check all for user_select
	$('.select_all').each(function () {
       $(this).change(function() {
            var chked = $(this).is(':checked');
    	    $(this).parents().parents().next("div").find(':checkbox').each(function () {
                $(this).prop('checked', chked)
            });
    	}); 
    });

    $(".tablesorter").tablesorter({
    // this will apply the bootstrap theme if "uitheme" widget is included
    // the widgetOptions.uitheme is no longer required to be set
    theme : "bootstrap",

    widthFixed: true,

    //headerTemplate : '{content} {icon}', // new in v2.7. Needed to add the bootstrap icon!

    // widget code contained in the jquery.tablesorter.widgets.js file
    // use the zebra stripe widget if you plan on hiding any rows (filter widget)
    widgets : [ "uitheme", "filter", "zebra" ],

    widgetOptions : {
      // using the default zebra striping class name, so it actually isn't included in the theme variable above
      // this is ONLY needed for bootstrap theming if you are using the filter widget, because rows are hidden
      zebra : ["even", "odd"],

      // reset filters button
      filter_reset : ".reset"

      // set the uitheme widget to use the bootstrap theme class names
      // this is no longer required, if theme is set
      // ,uitheme : "bootstrap"

    }});


    $("#document_filter_buttons li").click(function () {
        $(this).addClass("active");
        $(this).siblings("li").each(function () {
            $(this).removeClass("active");
        });

        $(".tab-pane").each(function () {
            $(this).removeClass("active");
        });

        var index = $(this).index();
        $("#tab" + index).addClass("active");
    });


    $("#allDocFilter").click(function(){
        $("#tab_all_documents").addClass("active");
        $("#tab_your_documents").addClass("active");
    });

    $("#yourDocFilter").click(function(){
        $("#tab_all_documents").removeClass("active");
        $("#tab_your_documents").addClass("active");
    });
    
    if ($("input#document_assigned_to_all_false").prop("checked") == true) {
        $("div#user_selection").show();
    } else {
        $("div#user_selection").hide();
    }

    $("input#document_assigned_to_all_true").change(function () {
        $("div#user_selection").hide();
    });

    $("input#document_assigned_to_all_false").change(function () {
        $("div#user_selection").show();
    });

});