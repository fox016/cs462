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
                    ).pick("$.content").decode();
        }
    }
    rule buildForm is active {
        select when web cloudAppSelected
        pre {
            movieFormHtml = <<
                <div id='dynamicContent' style='padding-left:20px'>
                </div>
                <form id='movieForm' name='movieForm' style='padding-left:20px;padding-top:20px'>
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
            total = movieResponse.pick("$.total");
            thumbUrl = movieResponse.pick("$.movies[0].posters.thumbnail");
            title = movieResponse.pick("$.movies[0].title");
            year = movieResponse.pick("$.movies[0].year");
            synopsis = movieResponse.pick("$.movies[0].synopsis");
            criticScore = movieResponse.pick("$.movies[0].ratings.critics_score");
            responseHtml = (total != 0) =>
                                "<div id='movieData'>" +
                                "Result Count: " + total +
                                "<table id='movieTable' style='border-collapse:collapse;border:2px solid #CCC'>" +
                                    "<tr><th>Thumbnail</th><td><img src='" + thumbUrl + "'></td></tr>" +
                                    "<tr><th>Title</th><td>" + title + "</td></tr>" +
                                    "<tr><th>Release Year</th><td>" + year + "</td></tr>" +
                                    "<tr><th>Synopsis</th><td>" + synopsis + "</td></tr>" +
                                    "<tr><th>Critic Ratings</th><td>" + criticScore + "</td></tr>" +
                                "</table>" +
                            "</div>" |
                            "<div style='padding:20px;'>No matches found for " + movieName + "</div>;
            responseHtml = responseHtml.replace(re/<th>/g, "<th style='padding:10px;text-align:left;vertical-align:top;border:2px solid #CCC'>");
            responseHtml = responseHtml.replace(re/<td>/g, "<td style='padding:10px;border:2px solid #CCC'>");
        }
        replace_inner("#dynamicContent", responseHtml);
        fired {
            log movieResponse;
        }
    }
}
