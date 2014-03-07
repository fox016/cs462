ruleset foursquare {
    meta {
        name "Lab 5 - Foursquare Checkin"
        description <<
            Foursquare Checkin Exercise
        >>
        author "Nate Fox"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    global {
    }
    rule process_fs_checkin {
	select when foursquare checkin
	pre {
	    checkinData = event:attr("checkin").decode();
	    venueName = (checkinData eq nil) =>
			event:attr("venueName") |
			checkinData.pick("$.venue.name");
	    city = (checkinData eq nil) =>
			event:attr("city") |
			checkinData.pick("$.venue.location.city");
	    shout = (checkinData eq nil) =>
			event:attr("shout") |
			checkinData.pick("$.shout");
	    createdAt = (checkinData eq nil) =>
			event:attr("createdAt") |
			checkinData.pick("$.createdAt");
	}
	always {
	    set ent:venueName venueName;
	    set ent:city city;
	    set ent:shout shout;
	    set ent:createdAt createdAt;
	    raise explicit event new_location_data for "b505195x7"
		with key = "fs_checkin"
		and value = {
				"venue": venueName,
				"city": city,
				"shout": shout,
				"createdAt": createdAt
		};
	}
    }
    rule display_checkin is active {
        select when web cloudAppSelected
        pre {
            checkinDataHtml = "" +
				"<table>" +
					"<tr><th>Venue Name</th><td>" + ent:venueName + "</td></tr>" +
					"<tr><th>City</th><td>" + ent:city + "</td></tr>" +
					"<tr><th>Shout</th><td>" + ent:shout + "</td></tr>" +
					"<tr><th>Created At</th><td>" + ent:createdAt + "</td></tr>" +
				"</table>";
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Lab 5 - Foursquare Checkin", {}, checkinDataHtml);
        }
    }
}
