class User < ApplicationRecord
	has_many :posts

	#has_many :user_relationship, foreign_key: :user_id, class_name: 'Post'
	#has_many :users, through: :user_relationship, source: :user

	has_many :follows

	has_many :follower_relationship, foreign_key: :followee_id, class_name: 'Follow'
	has_many :followers, through: :follower_relationship, source: :follower

	has_many :followee_relationship, foreign_key: :follower_id, class_name: 'Follow'
	has_many :followees, through: :followee_relationship, source: :followee

	validates :email, uniqueness: true, presence: true
	validates :name, uniqueness: true, presence: true
	has_secure_password

#	def valid_user_id(checkID)
#		if checkID == self.user_id
#			return true
#		else
#			errors.add(:user_id, "is not match")
#			return false
#		end
#	end
end
