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
	    venue = event:attr("venue");
	    city = event:attr("city");
	    shout = event:attr("shout");
	    createdAt = event:attr("createdAt");
	}
	fired {
	    set ent:venue venue;
	    set ent:city city;
	    set ent:shout shout;
	    set ent:createdAt createdAt;
	}
    }
    rule display_checkin is active {
        select when web cloudAppSelected
        pre {
            checkinDataHtml = "" +
				"<table>" +
					"<tr><th>Venue</th><td>" + ent:venue + "</td></tr>" +
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
