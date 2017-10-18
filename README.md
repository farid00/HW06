Github Repo: https://github.com/farid00/microblog
Deployed Application: http://microblog.ricksanchez.club
NGINX CONF: microblog.conf
systemd: microblog.service

Login: 
-You can login with any created User and your session is saved in a cookie. 
-Logout will remove the cookie and delete the session

Post:  
-Posts can be made by anyone and when logged out the posts will display all posts
-Once logged in the posts only display posts of those you follow so Anonymous posts with no user logged in will not be seen
-This behavior could be changed to allow the option to display anonymous posts or all posts to the reader depending on the direction this program ends up taking

Follows:  
-When you follow someone you can see their posts when you are logged in
-On your profile page you can see who you follow
-On a user page you can see who they follow
-You can choose to unfollow yourself which will mean you do not see your own posts ( this behavior may be prohibited in the future )
-You can unfollow people from your profile page or from their page.

Likes:  
You can like a post by going to the show page of the post.  There is a like button.  The post allows lists all the likes.  You can currently like a post more than once.

Deploy:  
Simple modify the path of the deploy helper so that it points to where it is located.  The deployment script will run the release commands and scp the file to the correct directory.  It will then ssh into the server, run the migrations and restart the program on the correct port.

Restart:   
-The server has been tested to restart the program properly and on the proper port upon server restart without any issues.

Live Updates:  
-Update are pushed to all users regardless of who they are following or if they are logged in 