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
	    checkinData = event:attr("checkin");
	  }
	  always {
	    set ent:checkinData checkinData;
	  }
	}
  rule display_checkin is active {
    select when web cloudAppSelected
    pre {
      checkinDataHtml = ent:checkinData;
    }
    {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Lab 8", {}, checkinDataHtml);
    }
  }
}
