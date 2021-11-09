class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  #belongs_to :user, foreign_key: :user_id, class_name: "User"

  def get_liker
    #return self.likes.map{ |like| like.user.name }.join(" ")
    #return User.where(:id => self.likes.pluck('user_id')).pluck('name')
    return self.likes.joins(:user).pluck('name')
  end
end

#select return ActiverRecord Association object
#pluck return array

#return self.likes.joins(:user).pluck('name')
#joining if like belong to user then like.joins(:user)
#joining if like has many users then like.joins(:users)