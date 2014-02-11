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
        notify("Warning", "This message will not self-destruct.") with sticky = true and position = bottom-left;
    }
    rule secondNotification {
        select when pageview ".*" setting ()
        notify("Warning", "This message will self-destruct.") with position = bottom-right;
    }
}
