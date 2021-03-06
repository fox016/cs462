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
    	locationSubMap =
    	{
    		"ec1":"12DD064C-B1FE-11E3-A9C6-35A4E71C24E1",
    		"ec2":"671DAFC2-B1FE-11E3-884D-1541293232C8"
    	};
    }
    rule dispatcher_rule {
    	select when foursquare checkin
    		foreach locationSubMap setting (n,v)
    	pre {
	    	checkinData = event:attr("checkin").decode();
	    	venueName = (checkinData eq nil) =>
				event:attr("venueName") |
				checkinData.pick("$.venue.name");
		city = (checkinData eq nil) =>
				event:attr("city") |
				checkinData.pick("$.venue.location.city");
		latitude = (checkinData eq nil) =>
				event:attr("latitude") |
				checkinData.pick("$.venue.location.lat");
		longitude = (checkinData eq nil) =>
				event:attr("longitude") |
				checkinData.pick("$.venue.location.lng");
    	}
    	{
    		send_directive("Lab 5 Foursquare Checkin Dispatch")
    			with attrs = {
					"venue": venueName,
					"city": city,
					"latitude": latitude,
					"longitude": longitude
			}
    			and cid_key = n;
    		event:send(locationSubMap, "location", "notification")
    			with attrs = {
					"venue": venueName,
					"city": city,
					"latitude": latitude,
					"longitude": longitude
			}
    			and cid_key = n;
    	}
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
	    latitude = (checkinData eq nil) =>
			event:attr("latitude") |
			checkinData.pick("$.venue.location.lat");
	    longitude = (checkinData eq nil) =>
			event:attr("longitude") |
			checkinData.pick("$.venue.location.lng");
	}
	send_directive("Process Foursquare Checkin")
		with key = "fs_checkin"
		and value = {
			"venue": venueName,
			"city": city,
			"shout": shout,
			"createdAt": createdAt,
			"longitude": longitude,
			"latitude": latitude
		};
	always {
	    set ent:venueName venueName;
	    set ent:city city;
	    set ent:shout shout;
	    set ent:createdAt createdAt;
	    set ent:longitude longitude;
	    set ent:latitude latitude;
	    raise explicit event new_location_data for b505195x7
		with key = "fs_checkin"
		and value = {
			"venue": venueName,
			"city": city,
			"shout": shout,
			"createdAt": createdAt,
			"longitude": longitude,
			"latitude": latitude
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
					"<tr><th>Latitude</th><td>" + ent:latitude + "</td></tr>" +
					"<tr><th>Longitude</th><td>" + ent:longitude + "</td></tr>" +
				"</table>";
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Lab 5 - Foursquare Checkin", {}, checkinDataHtml);
        }
    }
}
