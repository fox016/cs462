ruleset location_distance {
	meta {
		name "Lab 7 - Semantic Translation"
		description <<
			Compares Foursquare checkin location to user's current location
		>>
		author "Nate Fox"
		logging off
		use module b505195x7 alias LocationData
	}
	global {
	}
	rule test {
		select when mycurrent location
		pre {
			currentLatitude = event:attr("latitude");
			currentLongitude = event:attr("longitude");
		}
		send_directive("Current Location Test")
			with latitude = currentLatitude
			and longitude = currentLongitude;
	}
}
