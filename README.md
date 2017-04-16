Deployed Version: https://snack-picker.herokuapp.com

#Documentation: 

##Front end considerations: 

I deliberately did not use a front end framework such as AngularJS, becuase it makes internal apps more difficult to mantain, and because given the relatively small scope of the app, it didn't make sense to layer on another MVC, but if this app were bigger, it would be very suited to a js framework of some kind. Specifically to avoid full page refeshes on trivial actions.  

This would also allow us to update the vote count dynamically, rather than requiring the user to refresh to see how their snack is doing. (Also possible in vanilla rails with js, just more painful)

We did in fact use some javascript to update the votes page when an user votes, to avoid the need for a full refresh, but the suggestions page specifically would benefit greatly from adding more js. 

##Security Concerns:

We're doing all our vote count validation on the frontend, which means a canny user could delete their cookies and vote several times. The way around this, is of course to make a login system and track votes on a per user basis. For the purpses of this exercise we are *not* doing that, as the exercise requests we don't try to overreach, but the core idea would be to use devise to do authorization, and the have a votes table with an user_id, similar to what we do with the cookies currently. 

We should be proof against SQL injection and XSS attacks due to inbuilt ruby security, and being careful about user input sanitization. While the users can potentially modify the location info for suggestions of existing products, it doesn't actually affect anything as that data has already been permanently written to the API. 

##Testing:

This is pretty througuly tested for most model functions. Not everything that I wish were tested is tested due to time constraints (especially the controllers). Also, notably the suggestion_spec.rb hits the API. If those tests mysteriously fail, check that the API is up

I also did not do integration tests for an inward facing app. Had I had more time it might have been a consideration, although it should be noted that integration tests are a polarizing topic, their worth is certainly debatable. 

##Overarching Assumptions:  

This app assumes that the rake task included will be scheduled (via chron or heroku schedulizer), in order to wipe the database of votes and suggestions every month, (after sending off the data to some imaginary API that the purchasing department uses to decide what snacks to buy). No critcal data is kept there, and for an internal app it makes sense to not have a big, bloated, growing database. This is a tradeoff, if we decided we'd rather preserve historical data, this could be accheieved via a boolean in the "suggestion" table, with "suggested this month", as well as a "historical vote total" table. the rake task would set all those booleans to false at the begining of the month, then add the number of votes to the historical total, and set the votes to 0.

Eventually when we transition to users we're going to need a vote table, serving as a pseudo-join table, where each user would have many votes, and each suggestion would have many votes.

##Setup

To setup this app, first clone the repository. Bundle install the gems,  Then initalize figaro with  bundle exec figaro install, in config/application.yml set your API key, then run the rails server with rails s, connect to it at localhost:3000. 

For development, you can run guard, by just typing guard in the console, this will automatically run tests for you when you make a change! 

##tour
From the outside in, the snack_api model handles the api calls to the snack api, while snackData parses it down further, then the suggestion model handles the suggestions as well as parsing snackData info into suggestion specific methods. 

The controlers handle all logic for cookies, ensuring voters only vote the alloted number of times, and only make the allowed number of suggestions. They also throw errors when given invalid creation parameters. 

The front takes the user input and passes it onto the controlers, its entirely agnostic to what the data is. Bootstrap and some light js allow it to look pretty and be slightly dynamic. If any changes are made to the html, please ensure the js still works, as it relies on certain attributes being present. 