ruleset location_distance {
	meta {
		name "Lab 7 - Semantic Translation"
		description "Lab 7"
		author "Nate Fox"
		logging off
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
		use module b505195x7 alias LocationData
	}
	global {
	}
	rule test {
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
