class User < ApplicationRecord
	has_many :posts

	#has_many :user_relationship, foreign_key: :user_id, class_name: 'Post'
	#has_many :users, through: :user_relationship, source: :user

	has_many :follows

	has_many :follower_relationship, foreign_key: :followee_id, class_name: 'Follow'
	has_many :followers, through: :follower_relationship, source: :follower

	has_many :followee_relationship, foreign_key: :follower_id, class_name: 'Follow'
	has_many :followees, through: :followee_relationship, source: :followee

	has_many :likes

	# remember validate is call when trying to save or call valid?
	validates :email, uniqueness: true, presence: true
	validates :name, uniqueness: true, presence: true
#	validate :match_password

	has_secure_password

=begin  password_confirmation is nil. So, rip
	
end
	def match_password
		errors.add(:password, "mis match with password_confirm #{password}") if password != password_confirmation
  		errors.add(:password_confirm, "mis match with password #{password_confirmation}") if password != password_confirmation
  	end

=end

end
