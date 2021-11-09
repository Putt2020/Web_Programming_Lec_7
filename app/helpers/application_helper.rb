module ApplicationHelper
	def get_post_likedUser(postID)  #get all user who like this post, use in feed.html.haml & profile.html.haml
		@likeUid = Like.where(post_id: postID).pluck("user_id") 
		#puts "likeUid length is #{likeUid.count}"
		@likedUser = User.where(id: @likeUid)
		@arrLikedUser = []
		@likedUser.each do |user|
			@arrLikedUser.append(user.name)
		end
		#puts "likedUser length is #{@likedUser.count}"
		@noLike = @likedUser.empty?
	end

	def alreadyLiked(postID, userID)
		liked = Like.find_by(post_id: postID, user_id: userID)
		#puts "post ID : #{postID}, user ID : #{userID}, isnil : #{liked.nil?}"
		return !liked.nil?
	end

	def getLikeID(postID, userID)
		liked = Like.find_by(post_id: postID, user_id: userID)
		return liked.id
	end
end
