ruleset location_data {
	meta {
		name "Lab 6 - Event Networks"
		description <<
			Event Network Exercises
		>>
		author "Nate Fox"
		logging off
		provides get_location_data
	}
	global {
		get_location_data = function(mapKey) {
			ent:mymap{mapKey};
		}
	}
	rule add_location_item is active {
		select when explicit new_location_data
		pre {
			mapKey = event:attr("key");
			mapValue = event:attr("value");
			newMap = ent:mymap.put([mapKey], mapValue);
		}
		send_directive("Add Location Item")
			with map = newMap;
		always {
			set ent:mymap newMap;
		}
	}
}
