Github Repo: https://github.com/farid00/microblog
Deployed Application: http://microblog.ricksanchez.club

Login: 
-You can login with any created User and your session is saved in a cookie. 
-Logout will remove the cookie and delete the session

Post: 
-Posts can be made by anyone and when logged out the posts will display all posts
-Once logged in the posts only display posts of those you follow so Anonymous posts with no user logged in will not be seen
-This behavior could be changed to allow the option to display anonymous posts or all posts to the reader depending on the direction this program ends up taking

Follows:
-You must be logged in to follow not being logged in throws and error requesting log in
-When you follow someone you can see their posts when you are logged in
-On your profile page you can see who you follow
-On a user page you can see who they follow
-You can choose to unfollow yourself which will mean you do not see your own posts ( this behavior may be prohibited in the future )
-You can unfollow people from your profile page or from their page.

Errors:
-There is one unhandled error that causes a 500 message which is a non-logged in user attempting to view a user.  This has to do with the follow button and I simple ran out of time to implement and debug the problem. It is most likely caused in the template due to a lack of a user.

Restart: 
-The server has been tested to restart the program properly and on the proper port upon server restart without any issues.