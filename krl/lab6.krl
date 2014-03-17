ruleset location_data {
	meta {
		name "Lab 6 - Event Networks"
		description <<
			Event Network Exercises
		>>
		author "Nate Fox"
		key twillio{
			"account_sid" : "ACea96d6c53aec97a80594ab3163f9149e",
			"auth_token" : "eb4d4b5dc8d9397aefef74a17a9cde79"
		}
		logging off
		provides get_location_data
		use module a8x115 alias MyTwilio
	}
	global {
		get_location_data = function(mapKey) {
			ent:mymap{mapKey};
		}
	}
	rule add_location_item is active {
		select when explicit new_location_data
		pre {
			mapKey = event:attr("key");
			mapValue = event:attr("value");
			newMap = ({}.put([mapKey], mapValue));
		}
		send_directive("Add Location Item")
			with map = newMap;
		always {
			set ent:mymap newMap;
		}
	}
	rule text_when_near {
		select when explicit location_nearby
		pre {
			distance = event:attr("distance");
			message = "Distance: " + distance;
			to = "+18016166509";
			from = "+13852751421";
		}
		{
			send_directive("Location Nearby")
				with message = message;
			twilio:sms(message);
			MyTwilio:send_sms(to, from, message);
		}
	}
}
