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
        notify("Warning", "This message will not self-destruct.") with sticky = true and position = top-left;
    }
    rule secondNotification {
        select when pageview ".*" setting ()
        notify("Warning", "This message will self-destruct.");
    }
}
