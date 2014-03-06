ruleset location_data {
	meta {
		name "Lab 6 - Event Networks"
		description <<
			Event Network Exercises
		>>
		author "Nate Fox"
		logging off
		provide get_location_data
	}
	global {
		get_location_data = function(key) {
			ent:mymap{key};
		}
	}
	rule add_location_item is active {
		select when explicit new_location_data
		pre {
			key = event:attr("key");
			value = event:attr("value");
			newMap = ent:mymap.put([key], value);
		}
		always {
			set ent:mymap newMap;
		}
	}
}
