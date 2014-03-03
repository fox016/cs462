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
	    city = event:attr("city");
	    shout = event:attr("shout");
	    createdAt = event:attr("createdAt");
	    checkinData = event:attr("checkin").decode();
	    venuName = (checkinData eq nil) =>
			event:attr("venueName") |
			checkinData.pick("$.venue.name");
	}
	always {
	    set ent:venueName venueName;
	    set ent:city city;
	    set ent:shout shout;
	    set ent:createdAt createdAt;
	    set ent:checkin checkin;
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
					"<tr><th>Checkin</th><td>" + ent:checkin + "</td></tr>" +
				"</table>";
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Lab 5 - Foursquare Checkin", {}, checkinDataHtml);
        }
    }
}
