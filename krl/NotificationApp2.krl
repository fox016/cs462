ruleset NotificationApp {
    meta {
        name "Notification App"
        author "Nate Fox"
        logging off
    }
    global {
	getName = function(urlStr) {
		urlStr.split(re/&/).filter(function(pair) {pair.match(re/name/)}).head().replace(re/name=/, "")
	}
    }
    rule firstNotification {
        select when pageview ".*" setting ()
        {
            notify("Warning", "This message will not self-destruct.") with sticky = true and opacity = 1.0;
            notify("2nd Warning", "This message will self-destruct.") with opacity = 0.3;
        }
    }
    rule secondNotification {
        select when pageview ".*" setting ()
	pre {
	    queryStr = page:url("query");
	    helloStr = (getName(queryStr).match("")) => "Hello " + getName(queryStr)| "Hello Monkey";
	}
	notify("2nd Rule", helloStr) with sticky = true and opacity = 1.0;
    }
}
