ruleset examine_location {
	meta {
		name "Lab 6 - Event Networks: Examine Location"
		description <<
			Event Network Exercises: Examine Location
		>>
		author "Nate Fox"
		logging off
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
		use module b505195x7 alias LocationData
	}
	global {
	}
	rule show_fs_location is active {
		select when web cloudAppSelected
		pre {
			checkinData = LocationData:get_location_data("fs_checkin").decode();
			venue = checkinData.pick("$.venue");
			city = checkinData.pick("$.city");
			shout = checkinData.pick("$.shout");
			createdAt = checkinData.pick("$.createdAt");
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
