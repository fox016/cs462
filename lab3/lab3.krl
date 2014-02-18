ruleset NotificationApp {
    meta {
        name "Notification App"
        author "Nate Fox"
        logging off
    }
    global {
        isClearSet = function(urlStr) {
            (urlStr.split(re/&/).filter(function(pair) {pair.match(re/^clear/)}).head().replace(re/clear=/, "")) == "1"
        }
    }
    rule buildForm {
        select when pageview ".*" setting ()
        pre {
            fname = ent:fname;
            lname = ent:lname;
            myForm = ((fname eq nil)) => ("<form id='myForm' name='myForm'>" +
                        "<input type=text id='fname' name='fname'>" +
                        "<input type=text id='lname' name='lname'>" +
                        "<input type=submit id='formSubmit' value='Submit'>" +
                    "</form>") |
                    ("<p>First Name: " + fname + "<br>Last Name: " + lname + "</p>");
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
        replace_inner("#main", "<p>First Name: #{fname}<br>Last Name: #{lname}</p>");
        fired {
            set ent:fname fname;
            set ent:lname lname;
        }
    }
    rule clearNames {
        select when pageview ".*" setting()
        pre {
            doClear = isClearSet(page:url("query"));
        }
        fired {
            clear ent:fname if doClear;
            clear ent:lname if doClear;
        }
    }
}
