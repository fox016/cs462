ruleset MyLocationDistance {
	meta {
		name "Lab 7 - Semantic Translation"
		description "Lab 7"
		author "Nate Fox"
		logging off
                use module b505195x7 alias LocationData
	}
	global {
	}
	rule nearby {
		select when mycurrent mylocation
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
			with checkinLatitude = fsLatitude
			and checkinLongitude = fsLongitude
			and currentLatitude = currentLatitude
			and currentLongitude = currentLongitude
                        and distance = distance;
                always {
                        raise explicit event location_nearby
                                with distance = distance
                        if (distance < 5);
                        raise explicit event location_far
                                with distance = distance
                        if (distance >= 5);
                }
        }
}
