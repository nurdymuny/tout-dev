require 'itout'

client_id = "80c5a655ad20e8819dc0cf580e5828cb5474cd5692c8b39acd5ea8410756cdde"
client_secret = "5ca12cb9a77f1d1c5ad0e8c6369d910a12862b2a8a138eaa152fcac931c8842c"
token_key = "70f0a71219f60407f15e20602db02efc021e468432d65e14af6db90816f3cb54"
callback_url = "http://localhost:3000/"

# client init and auth
client = ITout.client(client_id, client_secret, callback_url, email:"tout@tout-dev.me", password:"139townsend")

#p client.user_auth()
client.client_auth()

user_touts = client.retrieve_user_touts("bluejacketsnhl")
p "***************************** Touts Count" + user_touts.count.to_s + "******************************"
user_touts.each_with_index do |u_tout, index|
	p "************************************" + index.to_s + "******************************************************"
	p "username---------------->" + u_tout.user.username
	p "avatar_url-------------->" + u_tout.user.avatar.profile.http_url
	p "text-------------------->" + u_tout.text
	p "created_at-------------->" + u_tout.created_at
	p "likes_count------------->" + u_tout.likes_count.to_s
	p "views_count------------->" + u_tout.views_count.to_s
	p "video_url--------------->" + u_tout.video.mp4.http_url
end

user_followers = client.retrieve_user_followers("bluejacketsnhl")
p "############################## Followers Count" + user_followers.count.to_s + "###################################"
user_followers.each_with_index do |u_follower, index|
	p "##############################" + index.to_s + "###################################"
	p "username---------------->" + u_follower.username
	p "avatar_url-------------->" + u_follower.avatar.profile.http_url	
	p "followers_count--------->" + u_follower.followers_count.to_s
	p "friends_count----------->" + u_follower.friends_count.to_s
	p "created_at-------------->" + u_follower.created_at
end

user_followings = client.retrieve_user_following("bluejacketsnhl")
p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Follow Count" + user_followings.count.to_s + "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
user_followings.each do |u_following|
	p "username---------------->" + u_following.username
	p "avatar_url-------------->" + u_following.avatar.profile.http_url	
	p "followers_count--------->" + u_following.followers_count.to_s
	p "friends_count--------->" + u_following.friends_count.to_s
	p "created_at-------------->" + u_following.created_at
end
 