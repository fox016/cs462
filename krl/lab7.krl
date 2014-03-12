ruleset mylocationdistance {
	meta {
		name "Lab 7 - Semantic Translation"
		description "Lab 7"
		author "Nate Fox"
		logging off
	}
	global {
	}
	rule process_my_current_location {
		select when mycurrent mylocation
		pre {
			currentLatitude = event:attr("latitude");
			currentLongitude = event:attr("longitude");
		}
		send_directive("Current Location Test")
			with latitude = currentLatitude
			and longitude = currentLongitude;
		always {
			set ent:mylat currentLatitude;
			set ent:mylong currentLongitude;
		}
	}
}
