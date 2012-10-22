		<h1>SPVM</h1>
		<h2>New PV</h2>
		<div class="form clearfix">
			<form id="pv_new" action="/pv/new" method="post">
				<p class="field title">
					<label for="title">Title</label><br />
					<input class="text ui-widget-content ui-corner-all" type="text" name="title" id="title" />
					%if 'title' in errors.keys():
						<br /><span class="error">{{errors['title']}}</span>
					%else:
						<span class="error"></span>
					%end
				</p>
				<p class="field date">
					<label for="date">Date</label><br />
					<input class="text ui-widget-content ui-corner-all" type="text" name="date" id="date" class="date datepicker" />
					%if 'date' in errors.keys():
						<br /><span class="error">{{errors['date']}}</span>
					%else:
						<span class="error"></span>
					%end
				</p>
				<p class="field time">
					<label for="time">Time</label><br />
					<input class="text ui-widget-content ui-corner-all" type="text" name="time" id="time" class="time timepicker" />
					%if 'time' in errors.keys():
						<br /><span class="error">{{errors['time']}}</span>
					%else:
						<span class="error"></span>
					%end
				</p>
				<p class="field location">
					<label for="location">Location</label><br />
					<input class="text ui-widget-content ui-corner-all" type="text" name="location" id="location" />
					%if 'location' in errors.keys():
						<br /><span class="error">{{errors['location']}}</span>
					%else:
						<span class="error"></span>
					%end
				</p>
				<p class="field description">
					<label for="description">Description</label><br />
					<input class="text ui-widget-content ui-corner-all" type="text" name="description" id="description" />
					%if 'description' in errors.keys():
						<br /><span class="error">{{errors['description']}}</span>
					%else:
						<span class="error"></span>
					%end
				</p>
				<p class="field submit">
					<input class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" type="submit" value="Create" />
				</p>
			</form>
		</div>
		<script type="text/javascript">
			reassignUiElements();
			assignButtonElements($('.form.clearfix'));
		</script>
		%rebase layout title='New PV &mdash; SPVM'