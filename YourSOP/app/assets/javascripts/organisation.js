$(document).ready(function () {

	var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    	
	var btn_add = $("#btn_add");
	btn_add.attr("disabled", "disabled");

	$("#organisation_user_email").attr("readonly", "readonly");

	$("#invite").change(function() {
		if (pattern.test($("#invite").val())) {
			btn_add.prop("disabled", "");
		}
		else {
			btn_add.prop("disabled", "disabled");
			console.log("AA");
		}
	});

	btn_add.click(function() {
		var mail = $("#invite").val();

		var existed = $("#organisation_user_email").val();
		if (existed == "") {
			$("#organisation_user_email").val(mail);
		}
		else {
			$("#organisation_user_email").val(existed + ";" + mail);
		}
		
		$("#invite").val("");
	});

	$("[name='chk_sop']").bootstrapSwitch();
	$("[name='chk_include']").bootstrapSwitch("size", "mini");
	$("[name='chk_include']").bootstrapSwitch("onText", "Yes");
	$("[name='chk_include']").bootstrapSwitch("offText", "No");

	$("select[name='sign_off_users'").multiselect();

	$("#btn_save").click(function() {
		var services = $("#services_table input:checkbox:checked").map(function(){
	      return $(this).val();
	    }).get();
	    //console.log(JSON.stringify(services));

	    $.ajax({
		      type: "PUT",
		      url: '/organisations/update_service',
		      data: JSON.stringify(services),
		      contentType: 'application/json',
		      dataType: 'json',
		      success: function(msg) {
		      	console.log(msg);
		        window.location = '/organisations/import';
		      }
		});
	});

	$("#btn_finish").click(function() {
		var excluded_doc = $("input[name='chk_include']:not(:checked)").map(function() {
			return $(this).val();
		}).get();

		var obj = {};
		obj.excluded_doc = excluded_doc
		obj.sign_off_users = [];
		$('select option:selected').each(function() {
			var doc_id = $(this).parent().attr("id").replace("assign_", "")
			var user = {};
			user.doc_id = doc_id
			user.user_id = $(this).val();

			obj.sign_off_users.push(user)
		})
		console.log(obj);

		$.ajax({
		      type: "PUT",
		      url: '/organisations/update_sops',
		      data: JSON.stringify(obj),
		      contentType: 'application/json',
		      dataType: 'json',
		      success: function(msg) {
		      	console.log(msg);
		        window.location = '/documents';
		      }
		});
	});

});