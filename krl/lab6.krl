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
	rule add_location_item {
		select when pds new_location_data
		pre {
			key = event:attr("key");
			value = event:attr("value");
		}
		always {
			set ent:mymap mymap.put([key], value);
		}
	}
}
