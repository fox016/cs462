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
		select when my_current location
		pre {
			checkinData = LocationData:get_location_data("fs_checkin");
			fsLatitude = checkinData{"latitude"};
			fsLongitude = checkinData{"longitude"};
			currentLatitude = event:attr("latitude");
			currentLongitude = event:attr("longitude");
			halfPi = math:pi()/2;
			earthRadius = 6378;
			distance = math:great_circle_distance(fsLongitude, halfPi - fsLatitude, currentLongitude, halfPi - currentLatitude, earthRadius);
		}
		send_directive("Current Location")
			with distance = distance;
		always {
			raise explicit event location_nearby
				with distance = distance
			if (distance < 5);
			raise explicit event location_far
				with distance = distance
			if (distance >= 5);
		}
	}
	rule test {
		select when my_current location
		pre {
			currentLatitude = event:attr("latitude");
			currentLongitude = event:attr("longitude");
		}
		send_directive("Current Location Test")
			with latitude = currentLatitude
			and longitude = currentLongitude;
	}
}
