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
            notify("Warning", "This message will self-destruct.") with opacity = 0.3;
        }
    }
}
