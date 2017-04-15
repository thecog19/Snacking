Documentation: 

Front end considerations: 

I deliberately did not use a front end framework such as AngularJS, becuase it makes internal apps more difficult to mantain, and because given the relatively small scope of the app, it didn't make sense to layer onn another MVC, but if this app were bigger, it would be very suited to a js framework of some kind. Specifically to avoid full page refeshes on trivial actions.  

This would also allow us to update the vote count dynamically, rather than requiring the user to refresh to see how their snack is doing. (Also possible in vanilla rails with js, just more painful)

Security Concerns

We're doing all our vote count validation on the frontend, which means a canny user could delete their cookies and vote several times. The way around this, is of course to make a login system and track votes on a per user basis. For the purpses of this exercise we are *not* doing that, as the exercise requests we don't try to overreach, but the core idea would be to use devise to do authorization, and the have a votes table with an user_id, similar to what we do with the cookies currently. 

We should be proof against SQL injection and XSS attacks due to inbuilt ruby security, and being careful about user input sanitization. 

Testing:

This is pretty througuly tested for most model functions.

I also did not do integration tests for an inward facing app. Had I had more time it might have been a consideration, although it should be noted that integration tests are a polarizing topic, their worth is certainly debatable. 

Overarching Assumptions:  

This app also assumes that the rake task included will be scheduled (via chron or heroku schedulizer), in order to wipe the database of votes and suggestions every month, (after sending off the data to some imaginary API that the purchasing department uses to decide what snacks to buy). No critcal data is kept there, and for an internal app it makes sense to not have a big, bloated, growing database. This is a tradeoff, if we decided we'd rather preserve historical data, this could be accheieved via a boolean in the "suggestion" table, with "suggested this month", as well as a "historical vote total" table. the rake task would set all those booleans to false at the begining of the month, then add the number of votes to the historical total, and set the votes to 0.

Eventually when we transition to user we're going to need a vote table, serving as a pseudo-join table, where each user would have many votes, and each suggestion would have many votes.