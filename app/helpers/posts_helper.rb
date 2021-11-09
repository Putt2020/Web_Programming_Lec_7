module PostsHelper
	def get_feed_post  #get all post from followee use in feed.html.haml
		weeIds = Follow.where(follower_id: @user.id).pluck('followee_id')
		weeIds.push(@user.id)
		@allpost = Post.where(user_id: weeIds).order("created_at DESC")
		return @allpost
    end

end
