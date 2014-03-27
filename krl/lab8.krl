ruleset Lab_8 {
  meta {
	name "Lab 8"
	description "Lab 8"
	author "Nate Fox"
	logging off
    	use module b505195x7 alias LocationData
    	use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
  }
  global {
  }
  rule location_catch {
	select when location notification
	pre {
		venue = event:attr("venue");
		city = event:attr("city");
		latitude = event:attr("latitude");
		longitude = event:attr("longitude");
	}
	always {
		set ent:venue venue;
		set ent:city city;
		set ent:latitude latitude;
		set ent:longitude longitude;
	}
  }
  rule display_checkin is active {
	select when web cloudAppSelected
	pre {
            checkinDataHtml = "" +
				"<table>" +
					"<tr><th>Venue Name</th><td>" + ent:venue+ "</td></tr>" +
					"<tr><th>City</th><td>" + ent:city + "</td></tr>" +
					"<tr><th>Latitude</th><td>" + ent:latitude + "</td></tr>" +
					"<tr><th>Longitude</th><td>" + ent:longitude + "</td></tr>" +
				"</table>";
	}
    	{
		SquareTag:inject_styling();
		CloudRain:createLoadPanel("Lab 8", {}, checkinDataHtml);
	}
  }
}
