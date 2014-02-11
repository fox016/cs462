ruleset NotificationApp {
    meta {
        name "Notification App"
        author "Nate Fox"
        logging off
    }
    global {
	getName = function(urlStr) {
		urlStr.split(re/&/).filter(function(pair) {pair.match(re/^name=/)}).head().replace(re/name=/, "")
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
	    queryStr = getName(page:url("query"));
	    helloStr = (queryStr.match("")) => "Hello " + queryStr| "Hello Monkey";
	}
	notify("2nd Rule", helloStr) with sticky = true and opacity = 1.0;
    }
    rule countFire {
        select when pageview ".*" setting ()
	notify("Count", ent:page_count);
	fired {
	    ent:page_count += 1 from 1 if true
	}
    }
}
