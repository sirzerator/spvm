function reassignUiElements() {
	$('.datepicker').datepicker(
		{
			dateFormat: "yy-mm-dd",
			changeMonth: true,
			changeYear: true,
			showAnim: "slideDown",
			defaultDate: new Date(),
			showButtonPanel: true,
			showOtherMonths: true,
			selectOtherMonths: true
		}
	);
	$('.timepicker').timepicker({
		timeFormat:	'hh:mm:ss',
		stepHour: 1,
		stepMinute: 5,
		defaultTime: 0,
		showAnim: "slideDown",
	});
}

function assignButtonElements(element) {
	subElements = ['ul.icons li', '.ui-button']

	for (i = 0; i < subElements.length; i++) {
		$(element).delegate(subElements[i], 'mouseover mouseout', function(event) {
			if (event.type == 'mouseover') {
				$(this).addClass('ui-state-hover');
			} else if (event.type == 'mouseout') {
				$(this).removeClass('ui-state-hover');
			}
		});
	}
}

function castDialog(model, action, properties, arguments) {
	$('<div/>', {
		id: model + '_' + action + '_dialog',
		title: properties.title
	}).appendTo('body');

	buttons = {}
	buttons[properties.OK] = function() {
		$('.error').html('');
		$('.ui-state-error').removeClass('ui-state-error');

		data = {}
		$('#' + model + '_ajax_' + action + ' input').each(function(i, el) {
			data[$(el).attr('id')] = $(el).val();
		});
		console.log(data);
		$.ajax("/" + model + "/ajax/" + action, {
			type: 'post',
			data: data
		}).done(function(response) {
			if (action == 'new' || action == 'edit') {
				if (response['id']) {
					newRow = null;
					if (action == 'edit') {
						newRow = $("#" + model + "_" + response['id']);
						newRow.html($("table." + model + " tbody .overflow").html());
					} else if (action == 'new') {
						newRow = $("table." + model + " tbody .overflow").clone();
					}

					var placeholdersRegExp=/\*\|(.+)\|\*/g;
					results = newRow.html().match(placeholdersRegExp);

					for (i = 0; i < results.length; i++) {
						if (results[i].substr(2,2) == 'id') {
							newRow.attr('id', model + '_' + response['id']);
							newRow.html(newRow.html().replace(/\*\|id\|\*/g, ""+response['id']));
							newRow.html(newRow.html().replace(/\*%7Cid%7C\*/g, ""+response['id']));
						} else {
							variableName = results[i].substr(2, results[i].length-4);
							var currentPlaceholderRegex = new RegExp("\\*\\|" + results[i].substr(2, results[i].length-4) + "\\|\\*", "g");
							newRow.html(newRow.html().replace(currentPlaceholderRegex, $('#' + variableName).val()));
						}
					}

					$("table." + model + " tbody tr.nothing").hide();

					if (action == 'new') {
						newRow.insertBefore($("table." + model + " tbody tr").last()).fadeIn().removeClass("overflow");
					}

					$("#" + model + '_' + action + '_dialog').dialog("close");
					$("#" + model + '_' + action + '_dialog').remove();
				} else {
					for (value in response) {
						$('.' + value + ' .error').html(response[value]);
						$('#' + value).addClass('ui-state-error');
					}
				}
			} else if (action == 'delete') {
				$("#" + model + "_" + data[model + "_id"]).fadeOut();

				$("#" + model + '_' + action + '_dialog').dialog("close");
				$("#" + model + '_' + action + '_dialog').remove();
			}
		});
	}

	buttons[properties.Cancel] = function() {
		$("#" + model + '_' + action + '_dialog').dialog("close");
		$("#" + model + '_' + action + '_dialog').remove();
	}

	$("#" + model + '_' + action + '_dialog').dialog({
		autoOpen: false,
		height: properties.height,
		width: properties.width,
		modal: properties.modal,
		resizable: properties.resizable,
		buttons: buttons,
		close: function() {
			if (properties['beforeClose']) {
				properties.beforeClose();
			}
			$(this).dialog("close");
			$("#" + model + '_' + action + '_dialog').remove();

		}
	});

	$("#" + model + '_' + action + '_dialog').load("/" + model + "/ajax/" + action, arguments, function() {
		reassignUiElements();
		$(this).dialog("open");
	});
}