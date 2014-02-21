ruleset NotificationApp {
    meta {
        name "Lab 4 - Rotten Tomatoes"
        description <<
            Rotten Tomatoes App
        >>
        author "Nate Fox"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    global {
        isClearSet = function(urlStr) {
            (urlStr.split(re/&/).filter(function(pair) {pair.match(re/^clear/)}).head().replace(re/clear=/, "")) == "1"
        }
    }
    rule buildForm is active {
        select when web cloudAppSelected
        pre {
            movieFormHtml = <<
                <form id='movieForm' name='movieForm'>
                    <label for='movieName'>Movie Name:</label>
                    <input type=text id='movieName' name='movieName'>
                </form>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Lab 4 - Rotten Tomatoes", {}, movieFormHtml);
        }
    }
    rule submitForm {
        select when web submit "#movieForm"
        pre {
            movieName = event:attr("movieName");
        }
        noop()
    }
}
