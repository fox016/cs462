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
	rule nearby {
		select when current location
		pre {
			checkinData = LocationData:get_location_data("fs_checkin");
			fsLatitude = checkinData{"latitude"};
			fsLongitude = checkinData{"longitude"};
			currentLatitude = event:attr("latitude");
			currentLongitude = event:attr("longitude");
		}
	}
}
