ruleset NotificationApp {
    meta {
        name "Notification App"
        author "Nate Fox"
        logging off
    }
    global {
    }
    rule buildForm {
        select when pageview ".*" setting ()
        pre {
            myForm = "<form id='myForm' name='myForm'>" +
                        "<input type=text id='fname' name='fname'>" +
                        "<input type=text id='lname' name='lname'>" +
                        "<input type=submit id='formSubmit' value='Submit'>" +
                    "</form>";
        }
        {
            replace_inner("#main", myForm);
            watch("#myForm", "submit");
        }
    }
    rule submitForm {
        select when web submit "#myForm"
        pre {
            fname = event:attr("fname");
            lname = event:attr("lname");
        }
        {
            set ent:fname fname;
            set ent:lname lname;
        }
    }
}
