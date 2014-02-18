ruleset NotificationApp {
    meta {
        name "Notification App"
        author "Nate Fox"
        logging off
    }
    global {
    }
    rule firstNotification {
        select when pageview ".*" setting ()
        {
            replace_inner("#main", "This is my text");
        }
    }
}
