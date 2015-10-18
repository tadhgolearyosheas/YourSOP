$(document).ready(function () {
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

        $("#status_filter_buttons input").click(function () {
            $(this).addClass("active btn-warning");
            $(this).siblings("input").each(function () {
            $(this).removeClass("active btn-warning");
        });
    });
  });

   //$('#risk_document_ids').multiselect({ 
   //      includeSelectAllOption: true,
   //        enableFiltering:true,    
   //        numberDisplayed: 6
   // });

   $(".nested_risk_form").each(function() {
        $(this).trigger({ type: 'nested:fieldAdded', field: $(this)});
   });

});

$(document).on('nested:fieldAdded', function(event){
  var field = event.field; 
  var impact = field.find(":radio");
  var likelihood = field.find("select");
  var score = field.find(":text");
  impact.change(function(){
    calculate_risk_score_event(impact.attr("name"), likelihood, score);
  });
 
  likelihood.change(function(){
    calculate_risk_score_event(impact.attr("name"), likelihood, score);
  }); 

  calculate_risk_score_event(impact.attr("name"), likelihood, score);

})


function calculate_risk_score(impact, likelihood) {
    return impact * likelihood;
}

function calculate_risk_score_event(x, y, z) {
    var score = calculate_risk_score($("input[name='" + x + "']:checked").val(), $(y).val());
    $(z).val(score);

    if (score > 0 && score < 6) {
        z.css({'background-color' : '#00FF00'});
    }

    if (score >= 6 && score <= 12) {
        z.css({'background-color' : '#FFFF33'});
    }

    if (score > 12 && score <= 25) {
        z.css({'background-color' : '#FF0000'});
    }

    var total_score = 0;
    $(".nested_risk_form").each(function() {
        total_score = total_score + parseInt($($(this).find(":text")).val());
    });

    $("#risk_score").val(total_score);
}
