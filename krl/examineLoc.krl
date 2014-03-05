ruleset examine_location {
	meta {
		name "Lab 6 - Event Networks: Examine Location"
		description <<
			Event Network Exercises: Examine Location
		>>
		author "Nate Fox"
		logging off
		use module b505195x7 alias LocationData
	}
	global {
	}
	rule show_fs_location is active {
		select when web cloudAppSelected
		pre {
			venue = get_location_data("venue");
			venue = get_location_data("city");
			venue = get_location_data("shout");
			venue = get_location_data("createdAt");
			checkinDataHtml = "" +
			"<table>" +
				"<tr><th>Venue Name</th><td>" + venue+ "</td></tr>" +
				"<tr><th>City</th><td>" + city + "</td></tr>" +
				"<tr><th>Shout</th><td>" + shout + "</td></tr>" +
				"<tr><th>Created At</th><td>" + createdAt + "</td></tr>" +
			"</table>";
		}
		{
			SquareTag:inject_styling();
			CloudRain:createLoadPanel("Lab 6 - Event Networks", {}, checkinDataHtml);
		}
	}
}
