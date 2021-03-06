<form id="point_edit" action="/point/edit" method="post">
	<input type="hidden" id="pv_id" name="pv_id" value="{{data['pv_id']}}" />
	<input type="hidden" id="point_id" name="point_id" value="{{data['id']}}" />
	<p class="field title">
		<label for="title">Title</label><br />
		<input class="text ui-widget-content ui-corner-all" type="text" name="title" id="title" value="{{data['title']}}" />
		%if 'title' in errors.keys():
			<br /><span class="error">{{errors['title']}}</span>
		%else:
			<br /><span class="error"></span>
		%end
	</p>
	<p class="field description">
		<label for="description">Description</label><br />
		<input class="text ui-widget-content ui-corner-all" type="text" name="description" id="description" value="{{data['description']}}" />
		%if 'description' in errors.keys():
			<br /><span class="error">{{errors['description']}}</span>
		%else:
			<br /><span class="error"></span>
		%end
	</p>
	<p class="field rank">
		<label for="rank">Rank</label><br />
		<input class="text ui-widget-content ui-corner-all" type="text" name="rank" id="rank" value="{{data['rank']}}" />
		%if 'rank' in errors.keys():
			<br /><span class="error">{{errors['rank']}}</span>
		%else:
			<br /><span class="error"></span>
		%end
	</p>
	<p class="field parent">
		<label for="parent_id">Parent</label><br />
		<select id="parent_id" name="parent_id">
			<option value="">---</option>
			%if points['count']:
				%for point in points['rows']:
					<option value="{{point['id']}}"{{!' selected="selected"' if data['parent_id'] == point['id'] else str(data['parent_id'])}}>{{point['title']}}</option>
				%end
			%end
		</select>
	</p>
	%if not get('ajax', False):
	<p class="field submit">
		<input class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" type="submit" value="Edit" />
	</p>
	%end
</form>
%if not get('ajax', False):
	%rebase forms title=title
%end