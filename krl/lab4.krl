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
        findMovie = function(movieName) {
            http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                    {"apikey": "gv2fpjtntpzg92rkmz7f53er",
                     "q": movieName
                    }
                    );
        }
    }
    rule buildForm is active {
        select when web cloudAppSelected
        pre {
            movieFormHtml = <<
                <div id='dynamicContent'>
                </div>
                <form id='movieForm' name='movieForm'>
                    <label for='movieName'>Movie Name:</label>
                    <input type=text id='movieName' name='movieName'>
                    <input type=submit value='Search'>
                </form>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Lab 4 - Rotten Tomatoes", {}, movieFormHtml);
            watch("#movieForm", "submit");
        }
    }
    rule submitForm {
        select when web submit "#movieForm"
        pre {
            movieName = event:attr("movieName");
            movieResponse = findMovie(movieName);
            title = movieResponse.pick("$.movies[0].title");
            responseHtml = "<div id='movieData'>" + title + "</div>";
        }
         replace_inner("#dynamicContent", responseHtml);
    }
}
