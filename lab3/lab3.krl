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
        pre {
            myForm = "<form>" +
                        "<input type=text id='fname' name='fname'>" +
                        "<input type=text id='lname' name='lname'>" +
                        "<input type=submit value='Submit'>" +
                    "</form>";
        }
        {
            replace_inner("#main", myForm);
        }
    }
}
