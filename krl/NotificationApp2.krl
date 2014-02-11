ruleset NotificationApp {
    meta {
        name "Notification App"
        author "Nate Fox"
        logging off
    }
    dispatch {
    }
    rule firstNotification {
        select when pageview ".*" setting ()
        {
            notify("Warning", "This message will not self-destruct.") with sticky = true and opacity = 0.3;
            notify("2nd Warning", "This message will self-destruct.") with opacity = 1.0;
        }
    }
    rule secondNotification {
        select when pageview ".*" setting ()
	pre {
	    queryStr = page:url("query");
	}
        notify("2nd Rule", "Hello " + queryStr) with stick = true and opacity = 1;
    }
}
