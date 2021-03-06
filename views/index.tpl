		<h1>SPVM</h1>
		<h2>PVs</h2>
		<table class="pvs">
			<thead>
				<th>#</th>
				<th>Titre</th>
				<th>Date</th>
				<th>Time</th>
				<th>Location</th>
				<th>Description</th>
				<th>Actions</th>
			</thead>
			<tbody>
			%if pvs['count']:
				%for row in pvs['rows']:
				<tr class="pv" id="pv_{{row['id']}}">
					<td>{{row['id']}}</td>
					<td><a href="/pv/{{row['id']}}">{{row['title']}}</a></td>
					<td>{{row['date']}}</td>
					<td>{{row['time']}}</td>
					<td>{{row['location']}}</td>
					<td>{{row['description']}}</td>
					<td>
						<ul class="icons ui-widget ui-helper-clearfix">
							<a href="/pv/edit/{{row['id']}}" class="pv edit" rel="{{row['id']}}" title="Edit"><li class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-pencil"></span></li></a>
							<a href="/pv/delete/{{row['id']}}" class="pv delete" rel="{{row['id']}}" title="Delete"><li class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-trash"></span></li></a>
						</ul>
					</td>
				</tr>
				%end
			%else:
				<tr class="pv nothing">
					<td colspan="7">Nothing to display.</td>
				</tr>
			%end
				<tr class="pv overflow">
					<td>*|id|*</td>
					<td><a href="/pv/*|id|*">*|title|*</a></td>
					<td>*|date|*</td>
					<td>*|time|*</td>
					<td>*|location|*</td>
					<td>*|description|*</td>
					<td><ul class="icons ui-widget ui-helper-clearfix"><li class="ui-state-default ui-corner-all"><a href="/pv/edit/*|id|*" class="pv edit" rel="*|id|*" title="Edit"><span class="ui-icon ui-icon-pencil"></span></a></li><li class="ui-state-default ui-corner-all"><a href="/pv/delete/*|id|*" class="pv delete" rel="*|id|*" title="Delete"><span class="ui-icon ui-icon-trash"></span></a></li></ul></td>
				</tr>
			</tbody>
		</table>
		<p class="buttons"><a href="/pv/new" class="button new pv"><button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"><span class="ui-button-text">New PV</span></button></a></p>
		<script type="text/javascript">
			$(document).ready(function() {
				assignButtonElements($('body'));
				$(".pv.new").click(function(e) {
					e.preventDefault();
					properties = {
						title:"New PV",
						OK:"Create",
						Cancel:"Cancel",
						width:200,
						height:330,
						modal:true,
						resizable:false,
						beforeClose: function() {}
					}
					castDialog('pv', 'new', properties, null);
				});
				$(".pvs").delegate(".pv.delete", "click", function(e) {
					e.preventDefault();
					properties = {
						title:"Are you sure you want to delete this PV ?",
						OK:"Yes",
						Cancel:"No",
						width:300,
						height:130,
						modal:true,
						resizable:false,
						beforeDone: function() {},
						beforeClose: function() {}
					}
					castDialog('pv', 'delete', properties, "pv_id=" + $(this).attr('rel'));
				});
				$(".pvs").delegate(".pv.edit", "click", function(e) {
					e.preventDefault();
					properties = {
						title:"Edit PV",
						OK:"Edit",
						Cancel:"Cancel",
						width:200,
						height:330,
						modal:true,
						resizable:false,
						beforeClose: function() {}
					}
					castDialog('pv', 'edit', properties, "pv_id=" + $(this).attr('rel'));
				});
			});
		</script>
		%rebase html title='SPVM'