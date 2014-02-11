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
	isClearSet = function(urlStr) {
		urlStr.split(re/&/).filter(function(pair) {pair.match(re/^clear/)}).length() > 0
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
	    queryName = getName(page:url("query"));
	    helloStr = (queryName.match("")) => "Hello " + queryName| "Hello Monkey";
	}
	notify("2nd Rule", helloStr) with sticky = true and opacity = 1.0;
    }
    rule countFire {
        select when pageview ".*" setting ()
	pre {
	    countStr = ((ent:ruleCount+1) <= 5) => ent:ruleCount+1 | "";
	}
	if countStr.match("") then
		notify("Count", countStr);
	fired {
	    ent:ruleCount += 1 from 1 if true
	}
    }
    rule clearCount {
        select when pageview ".*" setting ()
	pre {
	    isClear = (isClearSet(page:url("query")))
        }
	if isClear then
	    clear ent:ruleCount
    }
}
